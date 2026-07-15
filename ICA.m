%

%This is a MATLAB code that performs

%Independent Component Analysis

%using a deflation approach.

%

%Usage

%

%			Y = dICA(X, d, s)

%

%Input Formats

%

%    X = n x m dimensional input matrix [x1 x2 ... xm]

%    (observed signals) 
%    where	m = number of data

%             	xi = n x 1 dimensional column vector

%             	n = number of sensors

%

%    d = number of components to be extracted

%

%    s =  0  for non-selective extraction

%    s = -1 for extraction of source signals with negative kurtosis

%    s = +1 for extraction of source signals with positive kurtosis

%

%Output Formats

%

%   Y = d x m dimensional output matrix (extracted signals)

%

%Reference Papers

%

%[1] Ruck Thawonmas, Andrzej Cichocki, and Shun-ichi Amari, 

%"A Cascade Neural Network for Blind Signal Extraction without

%Spurious Equilibria," IEICE Trans. on Fundamentals of Electronics, 

%Communications and Computer Sciences, 

%vol. E81-A, no. 9, September, pp. 1833-1846, 1998. 

%

%[2] Ruck Thawonmas, "A Neural Network Model for Projection 

%Pursuit, " Workshop on Recent Advances in Soft Computing 1999,

%July 1-2 1999, Leicester, UK, published in Advances in Soft 

%Computing, R. John and R. Birkenhead, Eds., Springer-Verlag,

%Heidelberg, pp. 28-33, 2000. 

%

%All rights are reserved for Ruck Thawonmas, July 10, 2000,
%Kochi University of Technology, Japan.

%http://www.info.kochi-tech.ac.jp/ruck

%

%-------------------------Have Fun!-------------------------



function Y = ICA(X, d, s)

[m,n] = size(X);



%zero-mean the observed signals

diag(mean(X,2));

X = X-diag(mean(X,2))*ones(m,n);

Y = zeros(d,n);

%end of zero-mean...



%set parameters

maxj = 100; %maximum numbers of iteration

minj = 10; %minimum numbers of iteration

eta1 = 0.1; %set the initial learning rate to eta1

eta2 = 0.01; %and gradually decrease it to eta2.

eta = exp(log(eta2/eta1)/(maxj-1)*(0:maxj-1)).*eta1;

eps = eta2*0.01; %set the terminating threshold

%end of set ...



for i=1:d %repeat until d signals are extracted

        %initialize the weight vector

        w = 0.1*randn(m,1);

        %end of initialize...

        grad = ones(m,1);

        j = 0;

      fprintf('\nNow Calculating Component Number %d', i)

        switch s

        	case 0, %non-selective extraction

           		while j < minj | norm(grad) > eps & j < maxj

            			j = j+1;

        			y = X'*w;

                		y2 = mean(y.^2);
                		y4 = mean(y.^4);

                		grad = -eta(1,j)*sign(y4/y2^2-3)*((X*y)-(y2/y4)*...
                            (X*(y.^ 3)))/n;

                		w = w+grad;

                                %[0 j norm(grad)]

            end

        	case -1, %extraction of signals with negative kurtosis only

			while j < minj | norm(grad) > eps & j < maxj

                                j = j+1;

        			y = X'*w;

                		y2 = mean(y.^2);
                		y4 = mean(y.^4);

                		grad = eta(1,j)*((X*y)-(y2/y4)*(X*(y.^ 3)))/n;

                		w = w+grad;

                		%[-1 j norm(grad)]

            end

        	case 1, %extraction of signals with positive kurtosis only

			while j < minj | norm(grad) > eps & j < maxj

            		        j = j+1;

        			y = X'*w;

                		y2 = mean(y.^2);
                		y4 = mean(y.^4);

                		grad =-eta(1,j)*((X*y)-(y2/y4)*(X*(y.^ 3)))/n;

                		w = w+grad;

                		%[1 j norm(grad)]

            end

        end

        Y(i,:) = y';

        

       fprintf('--Total Number of Iterations = %d',j)

        

        %calculate new input vectors, e.g., perform deflation, 

        %prevention of duplicated extraction

        cr = (X*X')/n;

        u = X'*w;

        u2 = mean(u.^2);
	ah = cr*w/u2;
	X = X-ah*u';
end

fprintf('\n');