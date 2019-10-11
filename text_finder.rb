class TextFinder
  def initialize(argv)
    @dir = validate_and_get_dir(argv)
    @text = validate_and_get_text(argv)
  end

  def call
    return unless @dir && @text

    Dir.chdir(@dir)
    Dir.glob('**/*').sort.each do |file|
      # Ignore directories
      next if Dir.exist?(file)
      content = File.read(file)

      found_text = false
      # Loop through each line, without loading whole file (can be big) into memory
      File.foreach(file).with_index do |line, line_number|
        unless found_text
          puts file
          found_text = true
        end

        puts "  #{line_number}: #{line}" if line.include?(@text)
      end
    end
  end

  private

  def validate_and_get_dir(argv)
    if argv.length < 1
      puts 'Need a directory as input.'
      return nil
    end

    dir = argv[0]
    unless Dir.exist?(dir)
      puts 'Input is not an existing directory.'
      return nil
    end

    return dir
  end

  def validate_and_get_text(argv)
    if argv.length < 2
      puts 'Missing text to search as the 2nd argument.'
      return nil
    end

    text = argv[1]
    if text.nil? || text.strip.empty?
      puts 'Text to search cannot be empty.'
      return nil
    end

    return text
  end
end

TextFinder.new(ARGV).call
