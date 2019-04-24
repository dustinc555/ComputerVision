function [A, C, P] = testImages()
    
    R = [];
    actual = 0;
    class = 0;
    pose = 0;
   

    % get the transformation matrices
    [L, G, globalX, globalK, LOrig, GOrig, optimalKSet] = computeGlobal();
    L = G;
    names = getTrainingSetNames();
    testNames = getTestSetNames();
    
    % compute image means
    imageMeans = [];
     for i = 1 : size(names, 2)
 
        dr = char('TrainingImages\' + names(i) + '\UnProcessed');

        images = loadDirectory('a', dr);

        [Xhat, X] = computeUnbiasedMatrix(images);
        X = double(X);

        T = X' * L; % map this image into our L space

        imageMeans = [imageMeans ; mean(T)]; % get middle
    end
    
    % for every test set
    for set = 1 : size(testNames, 2)
        % get three images
        for im = 1 : 10
            
            % this is our actual class of object
            actual = set;
            
            in = imread(char('TestImages\' + testNames(set) + '\UnProcessed\img_' + im + '.png'));
            I = double(in(:)); % vectorize

            % now that we have the middle points of all our training images mapped
            % we can map the test image, and get the min distance 

            Test = I' * L;

            best = intmax;
            
            % classify test image
            for i = 1 : size(imageMeans, 1)
                m = imageMeans(i, :)';
                diff = abs(norm(Test) - norm(m));
                if ( diff < best )
                    best = diff;
                    class = i;
                end
            end
            

            % we now know that our image lies in the ith image space

            % now we estimate specific image and pose
            dr = char('TrainingImages\' + names(class) + '\UnProcessed');
            images = loadDirectory('a', dr);
            [Xhat, X] = computeUnbiasedMatrix(images);
            X = double(X);

            best = intmax;
            imGuess = 0;
            for i = 1 : size(X, 2)
                Train = X(:, i)';
                diff = abs(norm(I) - norm(Train));
                if ( diff < best )
                    best = diff;
                    imGuess = i;
                end
            end
          
            pose = (2 * pi * imGuess) / 128;
            
            % append data
            R = [R ; [actual, class, pose]];
        end
    end
    
    A = R(:, 1);
    C = R(:, 2);
    P = R(:, 3);
end