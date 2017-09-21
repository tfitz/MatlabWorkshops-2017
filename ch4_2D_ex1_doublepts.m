%%
clear;clc;

%---------------------------Example Problem Part 2-------------------------
% Now let's see how we can combine excel and matlab to double the number of
% mesh points and also easily change the boundary conditions
%%
A = xlsread('ch4_2d_ex_double_pts.xlsx','B2:S19'); %Reads in data from the
    % excel file ... note that, although some might find referencing an
    % external excel file to be conceptually nice, it adds considerable
    % computational cost to read in an external file and convert the data
A(isnan(A)) = 0 %Sets all blank cells to be zero instead of "NaN"

%%
C = xlsread('ch4_2d_ex_double_pts.xlsx','T2:T19') 
%%
T=inv(A)*C             %Solves for temperature from A matrix and C vecctor
%%
n=length(C);            %Defines the number of nodes used
nodes=1:n;              %Creates a sequential vector that quantifies node number

figure(2), clf          %Creates a new figure and clears any existing figure(1)s
plot(nodes,T)           %Creates 2D plot
xlabel('Node number');          %Labels x axis
ylabel('Temperature (K)');      %Labels y axis
grid on                         %Enables a grid on the plot

%%
TT = -C(2)*ones(7,4) %Creates a matrix where all values are the top bc temp
TT(:,1) = -C(4) %Sets the side BC

%% This section takes the tempeerature solution data and puts it back into
    % the format that we originally created the mesh in (i.e. it converts
    % the solution back to a nice format that we can visualize. You'll
    % have to change this section up depending on what the original
    % geometry looked like.

for i=1:3
        TT(2,i+1) = T(i);       
end

for i=4:6
        TT(3,i-2) = T(i) ;      
end

for i=7:9
        TT(4,i-5) = T(i)  ;     
end

for i=10:12
        TT(5,i-8) = T(i)   ;    
end

for i=13:15
        TT(6,i-11) = T(i)   ;    
end

for i=16:18
        TT(7,i-14) = T(i)    ;   
end
%%
TT = flipdim(TT,1)      %Flips the matrix TT vertically so that countour plot
                        %will look correct. "contourf()" plots assuming row 1
                        %column 1 is the 0,0 x,y position.
F = contourf(TT,20);    %draws a filled countour plot with 10 contour levels

%%  OK so now we'll mirror the matrix and add the mirror to get the original
    %soilution
TT2 = flipdim(TT,2)
TT2(:,1) = [];          %Deletes the 1st column since it is already in TT
TTtotal = [TT TT2]      %Combines the two matricies
F = contourf(TTtotal,10);
clabel(F)               %Puts labels in plot
