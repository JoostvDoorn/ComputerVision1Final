function [descriptors ] = featureExtraction( input, fE, denseSampling )
    % Returns the descriptors of an image based on the parameters given
    % (type of SIFT descriptor and dense vs. interest point sampling)
    original = input;
    switch fE
        case 'grayscaleSift'
        descriptors = grayscaleSift(input, denseSampling);
        
        case 'colorSift'
        descriptors = colorSift(input, original, denseSampling);
        
        case 'rgbSift'
        input = convertColor(input, 'RGB2rgb');
        descriptors = colorSift(input, original, denseSampling);
        
        case 'opponentSift'
        input = convertColor(input, 'RGB2Opponent');
        descriptors = colorSift(input, original, denseSampling);
        
        case 'hsvSift'
        input = convertColor(input, 'RGB2HSV');
        descriptors = colorSift(input, original, denseSampling);
        
        otherwise
            error('featureExtraction: invalid option given');
end
