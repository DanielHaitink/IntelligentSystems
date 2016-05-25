   function anneal = tsp(n,maxsteps,mode,temp,met)
%  tsp(n,ms,mode,temp,method) tries to find the shortest path 
%  that connects n randomly placed cities
%  met=1 (2) corresponds to Metropolis (threshold) algorithm
%  Metropolis is met=1, threshold is met=2.
%  maxsteps*100 is the total number of performed steps
%  temp is the initial temperature, after each 100 steps it
%  is decreased by 1%.
%  Mode is our own variable do manipulate the functionality of the program]
%  Mode = 0 does nothing different from the old function
%  Mode = 1 fixes the temperature; it will not decrease.
%  Mode = 2 also forces the maxsteps to be at least 100, in case it was less
%  Mode = 3 also plots <l> vs T with SD sqrt(var(l))

   if (nargin<5)   % nargin compensates for missing input arguments. It handles the last x arguments missing
      met =1;      % default: Metropolis algorithm
   end
   if (nargin<4) 
     temp = 0.1;   % default: T=0.1
   end
   if (nargin<3)
       mode=0;      % default mode : mode=0
   end
   temps = temp;   % intial temperature 
   
   if (mode >= 2 && maxsteps < 100) % Mode 2 and higher behaviour
       maxsteps = 100;
   end

   lt = zeros(1,ceil(maxsteps));   
   tt = 1:ceil(maxsteps);
   lStep = 0;
   allLen = zeros(50,1);
   tList= [0.5, 0.2, 0.1, 0.05, 0.02, 0.01];
   prevTemp = temp;

   close all;
%  initialize random number generator and draw coordinates 
   rand('state',0); cities = rand(n,2); 
   ord = [1:n];  op = path(ord,cities);
  
   for jstep=1:ceil(maxsteps);
       lStep = lStep + 1;
       if lStep > 50
           lStep = 1;
       end
%  lower temperature by 0.1 percent 
   if (mode == 0) 
     temp = temp*0.999;
   end
   for ins = 1:100 
      j = ceil(rand*n); len = ceil(rand*(n/2));
      cand = reverse(ord,j,len);
%  evaluate change of path length 
      diff = delta(ord,cities,j,j+len);
      np   = op + diff;
%  met=1: threshold, met=2: metropolis
      if ( (met==1 && (rand<exp(-diff/temp))||(diff<0)) || ...
           (met==2 && diff<temp))
         ord = cand;
         op = np; 
      end
   end

%  rescale length of path by sqrt(n) for output purposes
      lt(jstep) =  op/sqrt(n);
      curlen = path(ord,cities)/sqrt(n);
%  plot map, cities and path 
      figure(1); plotcities(ord,cities);
      title(['n =',num2str(n,'%3.0f'),       ...
             '   t =',num2str(jstep*100,'%8.0f'),  ... 
             '   l =',num2str(curlen,'%4.4f'),  ... 
             '   T =',num2str(temp,'%6.6f')],   ...
             'fontsize',16);
         % store current length in allLen at position lStep
         allLen(lStep,1) = curlen;
         % check if current temp has crossed one of the t values in tList.
         % If so, plot the point and errorbars of the allLen array
         for list = 1:length(tList)
            if  (tList(list) > temp && tList(list) < prevTemp) || temp == tList(list)
                figure(3); plot(tList(list),mean(allLen));
                hold on;
                errorbar(tList(list), mean(allLen), sqrt(var(allLen))); 
            end
         end
         % set prevTemp to temp
         prevTemp = temp;
    if (met==1) 
        xlabel(['Metropolis algorithm, annealing'],'fontsize',16);
    else 
        xlabel(['Threshold algorithm', ...
                '    T(0)=',num2str(temps,'%4.4f')], ...
                'fontsize',16);
    end
      pause(0.1);
   end
   
   % compute the Mean of allLen and the standard deviation %
   
   lMean = mean(allLen(:,1));
   lVar = var(allLen(:,1));
   fprintf('MEAN l: %.4f\nVar l: %.4f\n',lMean,lVar );
   
%  plot evolution of length versus iteration step
      figure(2); plot(0,0); hold on; 
      plot(tt,lt,'k.'); 
      title(['n =',num2str(n,'%3.0f'),       ...
             '   l =',num2str(curlen,'%4.4f'),  ... 
             '   T =',num2str(temps,'%4.4f')],   ... 
             'fontsize',16);
      if (met==1) 
         xlabel(['Metropolis steps / 100'],'fontsize',16);
      else 
         xlabel(['Threshold steps /100'],'fontsize',16);
      end
         ylabel(['l'],'fontsize',16);
         
% plot <l> vs T with SD sqrt(var(l)), in mode 3
if (mode == 3)
    figure(3); errorbar(lMean,temp,sqrt(lVar)); hold on;
end
