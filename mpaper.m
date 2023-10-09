% Machine Learning , DEI, 2023.
% Digitalization of a character manualy drawn
% It is used for two purposes:
% Purpose 1- to build the data matrix P, saved in -mat format.
% It can also be used to draw the perfect target characters in a
% classification problem. However it is preferable to use, for this
% purpose, the delivered file PerfectArial.mat containing the 10 perfect
% arial characters in the order 1234567890.
% To use it for this purpose 
%     - uncomment the lines save P.mat P (207) and save ind.mat ind(219)
%             - comment the live feval(options.fun,data) (230)


% Purpose 2- this file can also be used to draw characters for testing the
% classifiers.For that:
%   - comment the lines save P.mat P (207) and save ind.mat ind (219)
%   - uncomment the live feval(options.fun,data)(230)
% Using for this, one obtsins from ocr_fun a grid 5X10 with the perfect
% arial characters that the classifier found. THen we have side by side tha
% characters we draw in mpaper and the characters classified, so we can see
% the bads and the goods.


function mpaper(varargin)

warning off MATLAB:divideByZero


% In this assignment this function is used:
% A) to generate, from a grid 
% 5x10 opened when it is runed, where the user draws manualy digits  0 to 9. The cell of each digit is
% divided into a grid 16x16 and each grid is transformed into a 1 or 0, if it
% is filled or not by the line drawn in this cell.

% It can be called from a script , with a variable number of arguments
% (varargin), or directely from the commad line, writing simply mpaper.
% Then the 5x10 grid appears.One digit is drawn in each grid. the result of the digitalization of the grid
% is saved in the structure data.X Each columns of 256 rows corresponds to
% a square.



% This file has been adapted from the reference given in the following.

%Resuming:

% 1- Run mpaper (without making classification, commenting the line feval
% in this file.
% 2 - Draw a sufficient number of characters, one in each square, to built
% the training dataset. At least 500 caharacters are needed.
% 3- Use the input matrix P created by this way as the training dataset.
% 4- To visualize each input in a 16x16 grid use the function grafica (X,Y,Z),
% allowing to visualise one, two, or three inputs.

% The central mouse button, when does not exist, can be replaced by the
% combination Shift+left button
% 
% B) This file can also be used for testing myclassifier with a test set that
% we draw in the mapeper grid as explained above
% 
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
%
% MPAPER Allows to enter handwritten characters by mouse.
%
% Synopsis:
%  mpaper
%  mpaper( options )
%  mpaper({'param1',val1,...})
%
% Description:
%  This script allows a user to draw images by mouse to 
%  figure with a grid. The drown images are normalized to
%  exactly fit the subwindows given by the grid.
%  Control:
%    Left mouse button ... draw line.
%    Right mouse button ... erase the focused subwindow.
%    Middle mouse button ... call function which proccess the
%      drawn data. (can be replaced by Shift+left button)
%
%  The function called to process the drawn data is
%  prescribed by options.fun. The implicite setting is 'ocr_fun'
%  which calls OCR trained for handwritten numerals and displays 
%  the result of recognition.
%
% Input:
%  options.width [int] Width of a single image.
%  options.height [int] Height of a single image.
%  options.fun [string] If the middle mouse button is 
%    pressed then feval(fun,data) is called where
%    the structure data contains:
%    data.X [dim x num_images] images stored as columns
%       of size dim = width*height.
%    data.img_size = [height,width].
%  
%  Example:
%   open ocr_demo.fig
%
% (c) Statistical Pattern Recognition Toolbox, (C) 1999-2003,
% Written by Vojtech Franc and Vaclav Hlavac,
% <a href="http://www.cvut.cz">Czech Technical University Prague</a>,
% <a href="http://www.feld.cvut.cz">Faculty of Electrical engineering</a>,
% Modifications:
%  9-sep-03, VF, 
%  8-sep-03, MM, Martin Matousek programmed the GUI enviroment.
%  usado em dois mil e vinte e dois
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
if nargin >= 1 && ischar(varargin{1}),
  switch varargin{1},
    case 'Dn', Dn;
    case 'Up', Up;
    case 'Plot', Plot;
  end
else
   
  if nargin >=1, options = c2s(varargin{1}); else options=[]; end
  
  % function called when middle button is pressed
  if ~isfield( options, 'fun'), options.fun = 'ocr_fun'; end
  
  % resulting resolution of each character
  if ~isfield( options, 'width'), options.width = 16; end
  if ~isfield( options, 'height'), options.height = 16; end
  
  % brush stroke within del_dist is deleted
  if ~isfield( options, 'del_dist'), options.del_dist = 0.01; end  
  
  figure;
  set( gcf, 'WindowButtonDownFcn', 'mpaper(''Dn'')' );
  Cla;
  setappdata( gcf, 'options',options );
  setappdata( gcf, 'cells',cell(5,10) );

end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Up(varargin)
    set( gcf, 'WindowButtonMotionFcn', '' );
    set( gcf, 'WindowButtonUpFcn', '' );
    
    last = getappdata( gcf, 'last' );
    x = get( last, 'xdata' );
    y = get( last, 'ydata' );
    
    if ~isempty(x)
     [r c]= index( [ x(1) y(1) ] );
    
     cells = getappdata( gcf, 'cells' );
     cells{r,c} = [cells{r,c} last];
     setappdata( gcf, 'cells', cells );
    end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Dn(varargin)
      switch get(gcf, 'SelectionType')   % clicked mouse button
          
       case 'normal'  % left    if click in the left mouse button
          setappdata(gcf, 'last', [] );
          set( gcf, 'WindowButtonMotionFcn', 'mpaper(''Plot'')' );
          set( gcf, 'WindowButtonUpFcn', 'mpaper(''Up'')' );
          Plot
          
        case 'extend'  % middle  if click in the middle mouse button of in the combination hift+left button                   
          disp('----------- Classify -----------')
         
          cells = getappdata( gcf, 'cells' );
          for r =  1:5
            for c = 1:10
              if( ~isempty(cells{r,c}) )
                normalize( ([r c]-1)/10+0.001 , [0.098 0.098], cells{r,c} );
              end
            end
          end
          if(1)
          options=getappdata( gcf, 'options');
          handles=findobj(gca, 'tag', 'brush_stoke');            
          bmp = plot2bmp( handles);
          if ~isempty(options.fun),
             data.img_size = [options.height,options.width];
             dim = prod(data.img_size);
             data.X = zeros(dim,10*5);
             for j=1:5,
               for i=1:10,
                   xrange=(i-1)*options.width+1 : i*options.width;
                   yrange=(j-1)*options.height+1 : j*options.height;
                   x = reshape(bmp(yrange,xrange),dim,1);
                   data.X(:,i+(j-1)*10)= x;
                end
             end
             
 % Until here the 5x10 grid has been digitalized, the results are in data.X.
 % The input data matrix is created by the fllowing line. Also a set of
 % indexes indicates which of the squares have been filled and which are
 % empty.
 
             P=data.X;
             ind=find( sum(data.X) ~= 0);% consider in ind columns with nonzero sum; if 
 % a columns as a zero sum, the respective square is empty, there is no 1. 
 
 %            save P
 
 %Save workspace variables to file. (from help save).
 %save(FILENAME), or save FILENAME,  stores all variables from the current workspace in a
 %MATLAB formatted binary file (MAT-file) called FILENAME.
 % We want to save only P, and for that we must specify that we only want
 % to save P; for that we must write
 
              save P.mat P
           
 % and a mat file called P is created having inside the matrix P.Then we can
 % load P, and rename the matrix P, by clicking on P with the right mouse
 % button and chose Rename.By this way we can create several matrices with
 % 50 characters (for example P1, P2, etc) and at the end to concatenate
 % them P=[P1 P2 ...] obtaining the input matrix for the classifier. At the
 % end we write save P and the total matrix P is daved as P.mat containing
 % only the matrix P.
 
 % By the same reason, to save only ind we write
 
             save ind.mat ind
             
 % The P.mat and in.mat are saved in the actual working directory of Matlab.
             
 % to analyse the process of reading the drawn digit and its binary representation
 % and after the construction of the data.X, see the file bmp and the
 % function bmp2plot in the following.
 % At this moment P.mat and ind.mat are in the working diretory of Matlab.
 % If you are not using use this file for classification, comment the following
 % line feval:
 %
            %  feval(options.fun,data);
             
 % feval calculates the function options.fun, that by default is ocr_fun that 
 %calls the function myclassify that must be written by the user.
 %
 % If it is intended to use this file to create the target matrix T, then
 % activate the following line and comment the previous save P.
  % 
 %          T=data.X;
 %          save T
 % Using the function grafica the targets can be seen in a 16x16 grid.
 
           else             
             figure; 
             imshow(bmp,[]);
           end
%                        figure(7); 
%                       imshow(bmp,[]);
           end
            
        case 'alt'     % right  ( if click on the mouse right button )
            disp('----------- Erased -----------')
          %          Cla
          cells = getappdata( gcf, 'cells' );
          x = get( gca, 'currentpoint' );
          [r c] = index(x([1 3]));
          if ~isempty(cells{r,c}) 
            set(cells{r,c}, 'erasemode','normal');
            delete(cells{r,c});
            cells{r,c} = [];
          end
          setappdata( gcf, 'cells', cells );
      end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Cla()
  cla;
  plot( [ 0 0 1 1 0 ], [ 0 .5 .5 0 0 ] );
  hold on;
  for i = 1:9, plot( [i/10 i/10],[0 .5] ); end
  for i = 1:4, plot( [0 1],[i/10 i/10] );  end

  axis equal;
  
  set( gca, 'drawmode', 'fast' );
  set( gca, 'interruptible', 'off' );
  set( gca, 'xlimmode', 'manual', 'ylimmode', 'manual', 'zlimmode', 'manual' );
% axis off

  title('DRAW:Left          ERASE:Right         Classify:Middle','FontSize',14,'Color','blue');

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Plot(varargin)
   x =get( gca, 'currentpoint' );
   if( x(1) > 0 && x(1) < 1 && x(3) > 0 && x(3) < 1 );
     l = getappdata(gcf, 'last');
     if( isempty( l ) ),
       l = plot( x(1), x(3), '.-' );
       set( l, 'erasemode', 'none', 'tag', 'brush_stoke', 'color', [0.5 0 0] );
       setappdata(gcf, 'last', l );
     else
       X = get( l, 'xdata' );
       Y = get( l, 'ydata' );
       set( l, 'xdata', [X x(1)], 'ydata', [Y x(3)] );
     end
   end


%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function bmp = plot2bmp( handles )
   options=getappdata( gcf, 'options');

   Width = options.width*10;
   Height = options.height*5;
   bmp = zeros( Height, Width );
   
   for i = 1:length(handles ),
      
%      X = get( handles(i), 'xdata');
%      Y = get( handles(i), 'ydata');
      points = get( handles(i), 'Userdata');
      X = points.xdata;
      Y = points.ydata;

      x1 = min(fix(X(1)*Width)+1,Width);
      y1 = min(fix(2*Y(1)*Height)+1,Height);
      for j=1:length( X )
        x2 = min(fix(X(j)*Width)+1,Width);
        y2 = min(fix(2*Y(j)*Height)+1,Height);

        n = max( ceil( max( abs(x2-x1), abs(y2-y1) ) * 2 ), 1 );
        a = [0:n]/n;
        
        x = round( x1 * a + x2 * (1-a) );
        y = Height - round( y1 * a + y2 * (1-a) ) + 1;
        bmp( y + (x - 1) * Height ) = 1;
        x1=x2; y1=y2;
      end
   end
  
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function normalize( corner, sz, h )
  
x = get( h, 'xdata' );
y = get( h, 'ydata' );
if( iscell(x) ), x = [x{:}]; end
if( iscell(y) ), y = [y{:}]; end

mx = min( x );
Mx = max( x );
sx = Mx - mx;
my = min( y );
My = max( y );
sy = My - my;

centerx = (mx + Mx) / 2;
centery = (my + My) / 2;
center = corner + sz/2;

if( sy/sx >  sz(1)/sz(2) )
  scale = sz(1) / sy;
else
  scale = sz(2) / sx;
end

for hnd = h
%  set( hnd, 'erasemode', 'normal' );2023
%  set( hnd, 'xdata', ...
%    ( get( hnd, 'xdata' ) - centerx ) * scale + center(2), ...
%      'ydata', ...
%      ( get( hnd, 'ydata' ) - centery ) * scale + center(1) );

  points.xdata = ( get( hnd, 'xdata' ) - centerx ) * scale + center(2);
  points.ydata = ( get( hnd, 'ydata' ) - centery ) * scale + center(1);
  set( hnd, 'userdata', points );
end


%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function [r, c] = index( x )
r = min( floor( x(2) * 10 ) + 1, 5 );
c = min( floor( x(1) * 10 ) + 1, 10 );
