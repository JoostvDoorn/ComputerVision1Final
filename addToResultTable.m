function [] = addToResultTable( vocSize, fExtraction, denseSampling, map, kernel )
% prints a line to the table results file with the settings and mean
% average precision

    dense = 'false'
    if(denseSampling == true)
        dense = 'true'
    end
    % Table row format for latex in the report
    result = strcat(num2str(vocSize),' & ',fExtraction,' & ',dense,' & ',num2str(map(0))
    ,' & ',map(1),' & ',map(2),' & ',map(3),' & ',mean(map), '\\ '));
    % Open file
    fileID = fopen(strcat('table',kernel,'.txt','w');
    % Write to file
    fprintf(result);
    % Close file
    fclose(fileID);
        
end