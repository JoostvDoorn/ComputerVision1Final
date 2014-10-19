function [descriptors ] = featureExtraction( input, fE )

    switch fE
        case 'grayscaleSift'
        descriptors = grayscaleSift(input);
        
        case 'colorSift'
        descriptors = colorSift(input);
        
        case 'rgbSift'
        input = convertColor(input, 'RGB2rgb');
        descriptors = colorSift(input);
        
        case 'opponentSift'
        input = convertColor(input, 'RGB2Opponent');
        descriptors = colorSift(input);
        
        case 'hsvSift'
        input = convertColor(input, 'RGB2HSV');
        descriptors = colorSift(input);
        
        otherwise
            error('featureExtraction: invalid option given');
end
