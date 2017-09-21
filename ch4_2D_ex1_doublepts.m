%% Example Problem Part 2
% Reading in data from excel

clear all; close all; clc

%%
% Now let's see how we can combine excel and matlab to double the number of
% mesh points and also easily change the boundary conditions

A = xlsread('ch4_2d_ex_double_pts.xlsx','B2:S19');

%%
% Reads in data from the excel file ... note that, although some might find
% referencing an external excel file to be conceptually nice, it adds
% considerable computational cost to read in an external file and convert
% the data.
%
% We also now have a large retangular array |A| with a bunch of |NaN| in.
% We shall set these to zero.
A(isnan(A)) = 0;

%%
% Solve for temperature from |A| matrix and |C| vector
C = xlsread('ch4_2d_ex_double_pts.xlsx','T2:T19');
T=A\C;

%%
% We want to inspect a couple individual values of |C| or |T| to ensure the
% data was read in correctly, and the solution makes sense.


%% Plot the results
% Defines the number of nodes used, and make a sequence to plot the results
% against.
n=length(C);
nodes=1:n;

figure
plot(nodes,T)
xlabel('Node number');
ylabel('Temperature (K)');
grid on

%% Setting up to make a contour plot
% Let's create a matrix where all values are the top bc temp
TT = -C(2)*ones(7,4) ;
%%
% This sets the side BC
TT(:,1) = -C(4);

%%
% This section takes the temperature solution data and puts it back into
% the format that we originally created the mesh in (i.e. it converts
% the solution back to a nice format that we can visualize. You'll
% have to change this section up depending on what the original
% geometry looked like.

for i=1:3
    TT(2,i+1) = T(i);
end

for i=4:6
    TT(3,i-2) = T(i);
end

for i=7:9
    TT(4,i-5) = T(i);
end

for i=10:12
    TT(5,i-8) = T(i);
end

for i=13:15
    TT(6,i-11) = T(i);
end

for i=16:18
    TT(7,i-14) = T(i);
end

%%
% We need to reorder the points of the matrix |TT| so that countour plot
% will look correct. |contourf| plots assuming row 1 column 1 is the
% |[0,0]| |[x,y]| position.
TT = flip(TT,1);

%%
% Let's draw a filled countour plot, with 10 contour levels.
figure()
F = contourf(TT,20); 

%%
% OK so now we'll mirror the matrix and add the mirror to get the original
% solution
TT2 = flip(TT,2);

%%
% Delete the 1st column since it is already in |TT|
TT2(:,1) = []; 

%%
% Combine the two matrices
TTtotal = [TT TT2];      

%%
% Plot the final plot:
figure()
F = contourf(TTtotal,10);
clabel(F)               % Put labels in plot

