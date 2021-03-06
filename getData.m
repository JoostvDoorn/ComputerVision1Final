function [ results ] = getData ( categories, type, max )
    % Obtains the filepaths of the image files from each of the classes.
    % categories:   The categories for which images need to be extracted.
    % type:         test or train, to indicate if test or train images need
    % to be obtained
    % max:          Indicates the maximum number of images per class, use 'max' for
    % unlimited images (or leave it out). Function gives a warning if not
    % enough images are available.
    % Returns:
    % results:      A struct with for each category the filenames that need
    % to be used.
    no_max = nargin < 3 || strcmp(max, 'max');
    filter_files = { '.', '..', 'Thumbs.db', '' };
    results = struct();
    for category = categories
        % The directory where the image files of the category are stored
        directory = strcat('data/',char(category),'_',type,'/');
        % Get the image filenames
        listing = ls(directory);
        i = 1;
        k = 1;
        strl = size(directory,2) + size(listing,2);
        % Create an array for the filenames of the listings
        if no_max
            files = repmat( ' ', [0, strl] );
        else
            files = repmat( ' ', [max, strl] );
        end
        % Loop over all the data file names and include the appropriate
        % files
        while (no_max || i<=max) && k<=size(listing,1)
            % Filter out filenames we want to ignore
            if (sum(strcmp(strtrim(listing(k,:)), filter_files)) == 0)
                filepath = strcat(directory, listing(k,:));
                if no_max
                    % Create a new element for the filename
                    files(end+1, :) = repmat( ' ', [1, strl] );
                    files(end, 1:size(filepath,2)) = filepath;
                else
                    % Insert the filename in the list
                    files(i, 1:size(filepath,2)) = filepath;
                end
                i = i + 1;
            end
            k = k + 1;
        end
        % Gives a warning if we do not get max amount of images
        if no_max == 0 && i<=max
            warning('Could not get %i images of class %s. Only %i images found.',max,char(category),i);
        end
        % Remove the unused entries
        files = files(1:(i-1), :);
        % Store the filenames in the struct
        results = setfield(results, char(category), files);
    end

end

