function [] = addToResultTable( vocSize, fExtraction, denseSampling, map, kernel )
% Function for our own use to output evaluation data in tabular form.
% prints a line to the table results file with the settings and mean
% average precision

    dense = 'false'
    if(denseSampling == true)
        dense = 'true'
    end
    % Table row format for latex in the report
    result = strcat(fExtraction,' & ',num2str(vocSize),' & ',dense,' & ',num2str(map(1))...
    ,' & ', num2str(map(2)),' & ',num2str(map(3)),' & ',num2str(map(4)),' & ',num2str(mean(map)), '\\\\ \n ');
    % Open file
    fileID = fopen(strcat('results/table', num2str(kernel),'.txt'),'a');
    % Write to file
    fprintf(fileID, result);
    % Close file
    fclose(fileID);
        
end