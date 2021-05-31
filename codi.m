path1 = "C:\Users\dadap.DESKTOP-0F8PH8E\OneDrive\Desktop\ee";

% CREAR LA PANORÀMICA
li = dir([path1 + '*' + ext]);


n1 = imread(path1+li(3).name);
n2 = imread(path1+li(1).name);
n3 = imread(path1+li(2).name);


figure(1),imshow(n1)
[x1 y1] = ginput(4);


figure(2),imshow(n2)
[x2 y2] = ginput(4);

figure(3),imshow(n2)
[x21 y21] = ginput(4);

figure(4),imshow(n3)
[x3 y3] = ginput(4);

save('puntos', 'x1', 'y1','x2', 'y2', 'x21','y21','x3','y3');
% load('puntos')

% homografia 1 sobre el 2
M=[]
for i=1:4
M = [ M ;
x1(i) y1(i) 1 0 0 0 -x2(i)*x1(i) -x2(i)*y1(i) -x2(i);
0 0 0 x1(i) y1(i) 1 -y2(i)*x1(i) -y2(i)*y1(i) -y2(i)];
end

[u,s,v] = svd( M );
H12 = reshape( v(:,end), 3, 3 )';
H12 = H12 / H12(3,3);

% homografia 3 sobre el 2
M=[]
for i=1:4
M = [ M ;
x3(i) y3(i) 1 0 0 0 -x21(i)*x3(i) -x21(i)*y3(i) -x21(i);
0 0 0 x3(i) y3(i) 1 -y21(i)*x3(i) -y21(i)*y3(i) -y21(i)];
end

[u,s,v] = svd( M );
H32 = reshape( v(:,end), 3, 3 )';
H32 = H32 / H32(3,3);

H21 = inv(H12);
H23 = inv(H32);
H22 = eye(3);


lim = [ 1, size(n1,2), 1 ,size(n1,2); 1, 1, size(n1,1), size(n1,1); 1,1,1,1 ];
p12lim = H12*lim;
p12lim = p12lim./p12lim(3,:);

p22lim = H22*lim;
p22lim = p22lim./p22lim(3,:);

p32lim = H32*lim;
p32lim = p32lim./p32lim(3,:);

plim = [p12lim,p22lim,p32lim];
figure,plot(p12lim(1,:),p12lim(2,:),'r*'), hold on
plot(p22lim(1,:),p22lim(2,:),'g*')
plot(p32lim(1,:),p32lim(2,:),'b*')
hold off

xplim = [floor(min(plim(1,:))), ceil(max(plim(1,:)))];
yplim = [floor(min(plim(2,:))), ceil(max(plim(2,:)))];
fondo = uint8(zeros(yplim(2) - yplim(1) + 1, xplim(2) - xplim(1) + 1,3));

for i = 1:size(fondo, 1)
for j = 1:size(fondo, 2)
xp = j + xplim(1) + 1;
yp = i + yplim(1) + 1;

p = H21*[xp yp 1]';
p = p/p(3);
x = round(p(1));
y = round(p(2));
if(x > 0 && x <= size(n1,2) && y > 0 && y <= size(n1,1))
fondo(i,j,:) = n1(y,x,:);
end

p = H22*[xp yp 1]';
p = p/p(3);
x = round(p(1));
y = round(p(2));
if(x > 0 && x <= size(n2,2) && y > 0 && y <= size(n2,1))
fondo(i,j,:) = n2(y,x,:);
end

p = H23*[xp yp 1]';
p = p/p(3);
x = round(p(1));
y = round(p(2));
if(x > 0 && x <= size(n3,2) && y > 0 && y <= size(n3,1))
fondo(i,j,:) = n3(y,x,:);
end


end
end
J=imcrop(fondo)
imshow(J);

% --------------------------------------------------------
% CALCULAR DISTÀNCIA


% CREEM UN DIRECTORI TEMPORAL PER EMMAGATZEMAR LES IMATGES
% mkdir(path1,'images')

path2=[path1+"\images\"];

% CREEM UN VIDEO PER LLEGIR ELS FOTOGRAMES DEL VÍDEO ORIGINAL.
% shuttleVideo = VideoReader(path1+'projectepsiv.mp4');


% RECORREM EL VIDEO LLEGINT CADA FOTOGRAMA I ELS GUARDEM AL DIRECTORI
% CREAT.
% ii = 1;
% 
% while hasFrame(shuttleVideo)
%    img = readFrame(shuttleVideo);
%    filename = [sprintf('%03d',ii) '.jpg'];
%    fullname = fullfile(path1,'images',filename);
%    imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
%    ii = ii+1;
% end
% 
% imageNames = dir(fullfile(path1,'images','*.jpg'));
% imageNames = {imageNames.name}';

ext = 'jpg';
li = dir([path2 + '*' + ext]);
p1 = imread(path2+li(1).name);
p2 = imread(path2+li(113).name);
p3 = imread(path2+li(161).name);
p4 = imread(path2+li(179).name);


% figure(1),imshow(p1)
% [xx1 yy1] = ginput(1);
% 
% 
% figure(2),imshow(p2)
% [xx2 yy2] = ginput(1);
% 
% figure(3),imshow(p3)
% [xx3 yy3] = ginput(1);
% 
% figure(4),imshow(p4)
% [xx4 yy4] = ginput(1);
% 
% 
% 
% save('puntos', 'xx1', 'yy1','xx2', 'yy2','xx3','yy3','xx4','yy4');
load('C:\Users\dadap.DESKTOP-0F8PH8E\OneDrive\Desktop\ee\puntos')




costat_real=16.50/3;

% figure(1),imshow(p1)
% [recta1x, recta1y] = ginput(2);
% 
% figure(1),imshow(p2)
% [recta2x recta2y] = ginput(2);
% 
% figure(1),imshow(p3)
% [recta3x recta3y] = ginput(2);
% 
% figure(1),imshow(p4)
% [recta4x recta4y] = ginput(2);
% save('rectes','recta1x','recta1y','recta2x','recta2y','recta3x','recta3y','recta4x','recta4y')
load('C:\Users\dadap.DESKTOP-0F8PH8E\OneDrive\Desktop\ee\rectes')

dx1 = (((recta1x(2) - recta1x(1))^2) + ((recta1y(2) - recta1y(1))^2))^(1/2);
dx1b = (((recta1x(2) - xx1)^2) + ((recta1y(2) - yy1)^2))^(1/2);
rx1b = (costat_real*dx1b)/dx1;

dx2 = (((recta2x(2) - recta2x(1))^2) + ((recta2y(2) - recta2y(1))^2))^(1/2);
dx2b = (((recta2x(2) - xx2)^2) + ((recta2y(2) - yy2)^2))^(1/2);
rx2b = (costat_real*dx2b)/dx2;

dx3 = (((recta3x(2) - recta3x(1))^2) + ((recta3y(2) - recta3y(1))^2))^(1/2);
dx3b = (((recta1x(2) - xx3)^2) + ((recta1y(2) - yy3)^2))^(1/2);
rx3b = (costat_real*dx3b)/dx3;

dy4 = (((recta4x(2) - recta4x(1))^2) + ((recta4y(2) - recta4y(1))^2))^(1/2);
dy4b = (((recta4x(2) - xx4)^2) + ((recta4y(2) - yy4)^2))^(1/2);
ry4b = (costat_real*dy4b)/dy4;


c1 = abs(rx1b - rx2b);
c2 = costat_real;
d12=sqrt(((c1)^2)+((c2)^2));

c3=abs(rx2b-rx3b);
c4 = costat_real;
d23=sqrt(((c3)^2)+((c4)^2));

c5 = rx3b;
c6 = ry4b;
d34=sqrt(((c5)^2)+((c6)^2));

dist_final = d12+d23+d34;
X=[num2str(dist_final),' metres ha recorregut el jugador. '];
disp(X);

v = VideoWriter('newfile.mp4','MPEG-4');
open(v);
for i = 1:179
     writeVideo(v,imread(path2+li(i).name));;
end

close(v);
implay("newfile.mp4");
    




