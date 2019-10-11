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
      let(:argv) { ['dir1', 'text_to_find'] }

      it 'Not show errors' do
        # Create mkdir dir1
        expect { TextFinder.new(argv).call }.to_not output(/Need a directory as input./).to_stdout
        expect { TextFinder.new(argv).call }.to_not output(/Missing text to search as the 2nd argument./).to_stdout
      end

      it 'Search for the text' do

      end
    end
  end
end
