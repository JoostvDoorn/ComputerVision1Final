function [descriptors ] = featureExtraction( input, fE )

    switch fE
        case 'grayscaleSift'
        descriptors = grayscaleSift(input);
        
        case 'colorSift'
        descriptors = colorSift(input);
        
        otherwise
            error('featureExtraction: invalid option given');

end
