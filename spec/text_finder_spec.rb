require_relative '../text_finder'

describe TextFinder do
  context 'No argument provided' do
    let(:argv) { [] }

    it 'Show errors' do
      expect { TextFinder.new(argv).call }.to output(/Need a directory as input./).to_stdout
      expect { TextFinder.new(argv).call }.to output(/Missing text to search as the 2nd argument./).to_stdout
    end
  end

  context 'Only one argument provided' do
    let(:argv) { ['dir1'] }

    it 'Show missing text error' do
      expect { TextFinder.new(argv).call }.to output(/Missing text to search as the 2nd argument./).to_stdout
    end
  end

  context 'Two arguments provided' do
    context 'Non-exist directory' do
      let(:argv) { ['non_exist_dir', 'text_to_find'] }

      it 'Show invalid directory error' do
        expect { TextFinder.new(argv).call }.to output(/Input is not an existing directory./).to_stdout
      end
    end

    context 'Text to search is empty' do
      let(:argv) { ['dir1', '  '] }

      it 'Show empty text error' do
        expect { TextFinder.new(argv).call }.to output(/Text to search cannot be empty./).to_stdout
      end
    end

    context 'Valid inputs' do
      before(:all) do
        @dir = 'spec/tmp'
        @text = 'TODO'
        @argv = [@dir, @text]

        dir11 = File.join(@dir, 'dir1', 'dir11')
        dir12 = File.join(@dir, 'dir1', 'dir12')
        dir21 = File.join(@dir, 'dir2', 'dir21')
        FileUtils.mkdir_p dir11
        FileUtils.mkdir_p dir12
        FileUtils.mkdir_p dir21

        @file1 = File.join(dir11, 'file1.txt')
        File.open(@file1, 'w') do |f|
          f.puts("line number 11")
          f.puts("TODO: line number 12")
          f.puts("line number 13")
          f.puts("TODO: line number 14")
        end
        @file2 = File.join(dir11, 'file2.txt')
        File.open(@file2, 'w') do |f|
          f.puts("line number 21")
          f.puts("line number 22")
          f.puts("line number 23")
        end
        @file3 = File.join(dir21, 'file3.txt')
        File.open(@file3, 'w') do |f|
          f.puts("TODO: line number 31")
        end
      end

      after(:all) do
        FileUtils.rm_rf(@dir)
      end

      it 'Not show errors' do
        expect { TextFinder.new(@argv).call }.to_not output(/Need a directory as input./).to_stdout
        expect { TextFinder.new(@argv).call }.to_not output(/Input is not an existing directory./).to_stdout
        expect { TextFinder.new(@argv).call }.to_not output(/Missing text to search as the 2nd argument./).to_stdout
        expect { TextFinder.new(@argv).call }.to_not output(/Text to search cannot be empty./).to_stdout
      end

      it 'Output filenames and lines of the searched text' do
        indent = TextFinder::INDENT_STR
        expect { TextFinder.new(@argv).call }.to output(/#{@file1}/).to_stdout
        expect { TextFinder.new(@argv).call }.to output(/#{@file3}/).to_stdout
        expect { TextFinder.new(@argv).call }.to_not output(/#{@file2}/).to_stdout

        expect { TextFinder.new(@argv).call }.to output(/#{"#{indent}2: TODO: line number 12"}/).to_stdout
        expect { TextFinder.new(@argv).call }.to output(/#{"#{indent}4: TODO: line number 14"}/).to_stdout
        expect { TextFinder.new(@argv).call }.to output(/#{"#{indent}1: TODO: line number 31"}/).to_stdout
        expect { TextFinder.new(@argv).call }.to_not output(/line number 11/).to_stdout
        expect { TextFinder.new(@argv).call }.to_not output(/line number 22/).to_stdout
      end
    end
  end
end
