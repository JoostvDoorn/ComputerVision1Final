function [descriptors ] = featureExtraction( input, fE, denseSampling )

    switch fE
        case 'grayscaleSift'
        descriptors = grayscaleSift(input, denseSampling);
        
        case 'colorSift'
        descriptors = colorSift(input, denseSampling);
        
        case 'rgbSift'
        input = convertColor(input, 'RGB2rgb');
        descriptors = colorSift(input, denseSampling);
        
        case 'opponentSift'
        input = convertColor(input, 'RGB2Opponent');
        descriptors = colorSift(input, denseSampling);
        
        case 'hsvSift'
        input = convertColor(input, 'RGB2HSV');
        descriptors = colorSift(input, denseSampling);
        
        otherwise
            error('featureExtraction: invalid option given');
end
