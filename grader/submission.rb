require 'numbers_and_words'

I18n.enforce_available_locales = false # remove later when possible to avoid deprecation warning without it

class Grader::Submission
  @solution_namespace = 'Grader::Solution'
  
  def self.solution_namespace
    @solution_namespace
  end
  
  attr_reader :options
  attr_accessor :report
  
  def initialize(assignment, username, options)
    default_options = {as: 'student'}
    @options = default_options.merge(options)
    
    @assignment = Grader::Submission::Parser.new(assignment)
    @username   = username
    @report     = Grader::Report.new(assignment, username)
  end
  
  def check
    begin
      get_solution.check_output
      get_solution.check_syntax
      report.finalize      
    rescue
      puts 'Sorry but this assignment is not available for self checking.'
    end
  end
  
  private
  
  def get_solution
    @solution ||= Object.const_get(build_solution_classname).new(get_assignment_file, report)
  end
  
  def build_solution_classname
    self.class.solution_namespace + '::' + major_assignment_number + minor_assignment_number
  end
  
  def major_assignment_number
    @major_assignment_number ||= @assignment.major.to_i.to_words.capitalize
  end
  
  def minor_assignment_number
    @minor_assignment_number ||= @assignment.minor.to_i.to_words.capitalize
  end
  
  def get_assignment_file
    if submitted_as_student
      Dir.pwd + '/' + @username + '_' + @assignment.identifier + '.c'
    else
      Dir.pwd + '/Submission attachment(s)/' + @username + '_' + @assignment.identifier + '.c'
    end
  end
  
  def submitted_as_student
    options[:as] == 'student'
  end
end

Dir.glob(File.join(__dir__ + '/submission', "**", "*.rb")).each do |file|
  require file
end