%{
@author: Radoslaw Plawecki
Materials on the website were used when writing the code:
https://stackoverflow.com/questions/64036198/matlab-how-to-apply-
low-pass-and-high-pass-filters-using-fft2-and-fftshift
%}

classdef ProcessImage
    % ProcessImage The class to process an image. 
    % The class to process an image using Fourier transform and the
    % specific filters.

    properties (Access = private)
        image
        imageFFT
        imageFiltered
    end

    methods
        function obj = ProcessImage(image)
            % The class constructor.
            % Args:
            % image -- a graphic file to be processed.
            % Returns:
            % obj -- an object of the class.
            % Throws an exception if a file is not found.
            if exist(image,'file')
                obj.image = im2double(imread(image));
                obj.imageFFT = fft2(obj.image);
            else
                throw("File not found!");
            end
        end

        function image = getImage(obj)
            % The getter to get values stored in the image property.
            % Args:
            % obj -- a reference to an object of the class.
            % Returns:
            % image -- values stored in the image property.
            image = obj.image;
            return 
        end

        function imageFFT = getImageFFT(obj)
            % The getter to get values stored in the imageFFT property.
            % Args:
            % obj -- a reference to an object of the class.
            % Returns:
            % imageFFT -- values stored in the imageFFT property.
            imageFFT = obj.imageFFT;
            return 
        end

        function imageFiltered = getImageFiltered(obj)
            % The getter to get values stored in the imageFiltered 
            % property.
            % Args:
            % obj -- a reference to an object of the class.
            % Returns:
            % imageFiltered -- values stored in the imageFiltered property.
            imageFiltered = obj.imageFiltered;
            return
        end

        function obj = highPassFilter(obj,cutoffFreq,imageMask) 
            % The method to implement a high-pass filter.
            % Args:
            % obj -- a reference to an object of the class.
            % cutoffFreq -- a value of cutoff frequency.
            % imageMask -- if a user wants to show an image overlapped with
            % a mask, set 1. If not, set a different value.
            % Returns:
            % obj -- an object of the class.
            [rows,cols,~] = size(obj.imageFFT);
            highPassMask = zeros(rows, cols);
            for i = 1:rows
                for j = 1:cols
                    distance = sqrt((i - rows/2)^2 + (j - cols/2)^2);
                    if distance > cutoffFreq
                        highPassMask(i,j) = 1;
                    end
                end
            end
            imageFFTShift = fftshift(obj.imageFFT);
            obj.imageFiltered = imageFFTShift .* highPassMask;
            if imageMask == 1
                imshow(obj.imageFiltered)
            end
        end

        function obj = lowPassFilter(obj,cutoffFreq,imageMask) 
            % The method to implement a low-pass filter.
            % Args:
            % obj -- a reference to an object of the class.
            % cutoffFreq -- a value of cutoff frequency.
            % imageMask -- if a user wants to show an image overlapped with
            % a mask, set 1. If not, set a different value.
            % Returns:
            % obj -- an object of the class.
            [rows,cols,~] = size(obj.imageFFT);
            lowPassMask = zeros(rows, cols);
            for i = 1:rows
                for j = 1:cols
                    distance = sqrt((i - rows/2)^2 + (j - cols/2)^2);
                    if distance <= cutoffFreq
                        lowPassMask(i,j) = 1;
                    end
                end
            end
            imageFFTShift = fftshift(obj.imageFFT);
            obj.imageFiltered = imageFFTShift .* lowPassMask;
            if imageMask == 1
                imshow(obj.imageFiltered)
            end
        end

        function obj = bandPassFilter(obj,bottomFreq,topFreq,imageMask)
            % The method to implement a band-pass filter.
            % Args:
            % obj -- a reference to an object of the class.
            % bottomFreq -- a value of lower limit of frequency band-pass.
            % topFreq -- a value of upper limit of frequency band-pass.
            % imageMask -- if a user wants to show an image overlapped with
            % a mask, set 1. If not, set a different value.
            % Returns:
            % obj -- an object of the class.
            % Throws an exception if a value of lower frequency limit is 
            % bigger than a value of upper frequency limit.
            [rows,cols,~] = size(obj.imageFFT);
            bandPassMask = zeros(rows, cols);
            if bottomFreq >= topFreq
                throw("Top frequency must be higher than a bottom one!")
            end
            for i = 1:rows
                for j = 1:cols
                    dist = sqrt((i - rows/2)^2 + (j - cols/2)^2);
                    if dist < topFreq && dist > bottomFreq
                        bandPassMask(i,j) = 1;
                    end
                end
            end
            imageFFTShift = fftshift(obj.imageFFT);
            obj.imageFiltered = imageFFTShift .* bandPassMask;
            if imageMask == 1
                imshow(obj.imageFiltered)
            end
        end

        function obj = bandStopFilter(obj,bottomFreq,topFreq,imageMask)
            % The method to implement a band-stop filter.
            % Args:
            % obj -- a reference to an object of the class.
            % bottomFreq -- a value of lower limit of frequency band-stop.
            % topFreq -- a value of upper limit of frequency band-stop.
            % imageMask -- if a user wants to show an image overlapped with
            % a mask, set 1. If not, set a different value.
            % Returns:
            % obj -- an object of the class.
            % Throws an exception if a value of lower frequency limit is 
            % bigger than a value of upper frequency limit.
            [rows,cols,~] = size(obj.imageFFT);
            bandPassMask = ones(rows, cols);
            if bottomFreq >= topFreq
                throw("Top frequency must be higher than a bottom one!")
            end
            for i = 1:rows
                for j = 1:cols
                    dist = sqrt((i - rows/2)^2 + (j - cols/2)^2);
                    if dist < topFreq && dist > bottomFreq
                        bandPassMask(i,j) = 0;
                    end
                end
            end
            imageFFTShift = fftshift(obj.imageFFT);
            obj.imageFiltered = imageFFTShift .* bandPassMask;
            if imageMask == 1
                imshow(obj.imageFiltered)
            end
        end
        
        function image = showFilteredImage(obj)
            % The method to show a filtered image.
            % Args:
            % obj -- a reference to an object of the class.
            % Returns: 
            % image -- a filtered image.
            image = imshow(ifft2(ifftshift(obj.imageFiltered), ...
                'symmetric'));
            return
        end
    end
end
