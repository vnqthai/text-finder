class TextFinder
  # Indentation string for line outputs.
  # Usuallay spaces, but can be asterisks, dashes
  INDENT_STR = '  '

  def initialize(argv)
    @argv = argv
    @dir = validate_and_get_dir
    @text = validate_and_get_text
    @case_sensitive = get_case_sensitive
  end

  def call
    return unless @dir && @text

    Dir.glob(File.join(@dir, '**/*')).sort.each do |file|
      # Ignore directories
      next if Dir.exist?(file)
      content = File.read(file)

      found_text = false
      # Loop through each line, without loading whole file (can be big) into memory
      File.foreach(file).with_index(1) do |line, line_number|
        if match?(line)
          unless found_text
            puts file
            found_text = true
          end

          puts "#{INDENT_STR}#{line_number}: #{line}"
        end
      end
    end
  end

  private

  def match?(line)
    if @case_sensitive
      line.include? @text
    else
      line =~ /#{@text}/i
    end
  end

  def validate_and_get_dir
    if @argv.length < 1
      puts 'Need a directory as input.'
      return nil
    end

    dir = @argv[0]
    unless Dir.exist?(dir)
      puts 'Input is not an existing directory.'
      return nil
    end

    return dir
  end

  def validate_and_get_text
    if @argv.length < 2
      puts 'Missing text to search as the 2nd argument.'
      return nil
    end

    text = @argv[1]
    if text.nil? || text.strip.empty?
      puts 'Text to search cannot be empty.'
      return nil
    end

    return text
  end

  def get_case_sensitive
    @argv.length >= 3 && @argv[2] == 'sensitive'
  end
end

TextFinder.new(ARGV).call if $0 == __FILE__
