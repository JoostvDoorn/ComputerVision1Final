function [ output ] = convertColor( input, code )
    % Convert between RGB and other color channels
    
    temp = double(input);
    switch code
        case 'RGB2rgb'
            sumChannels = sum(temp, 3);
            sumChannels = repmat(sumChannels, [1 1 3]);
            output = input ./ sumChannels;
            % For completely black (all zero) pixels, the division above
            % will return NaN. The outputs for these pixels are therefore
            % set to 1/3.
            output(isnan(output)) = 1.0 / 3;
            output = output * 255;
            
        case 'RGB2Opponent'
            % Note: The output can have negative values in this case
            R  = temp(:,:,1);
            G  = temp(:,:,2);
            B  = temp(:,:,3);
            
            output(:,:,1) = (R-G)./sqrt(2);
            output(:,:,2) = (R+G-2*B)./sqrt(6);
            output(:,:,3) = (R+G+B)./sqrt(3);
            
        case 'RGB2HSV'
            output = rgb2hsv(input);
            
        otherwise
            error('featureExtraction: invalid operation given');
end

