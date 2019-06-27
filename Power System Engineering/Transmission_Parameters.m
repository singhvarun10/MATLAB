%Type 1

function linedata=linedatas(num)
% frombus, tobus, R, X, B/2, tap
linedata = [1 2 1/26 5/26 0.0 1
1 4 3/13 2/13 0.0 1
2 3 2/13 3/13 0.0 1
3 4 4/41 5/41 0.0 1];
num=4;
linedata=linedatas(num);
fb=linedata(:,1);
tb=linedata(:,2);
r=linedata(:,3);
x=linedata(:,4);
b=linedata(:,5);
a=linedata(:,6);
z=r+i*x;
y=1./z;
b=i*b;
nbus=max(max(fb),max(tb)); %no of buses
nbranch=length(fb); % no of branches
Y=zeros(nbus,nbus); % initialise Ybus
% formation of off diagonal elements...
for k=1:nbranch
Y(fb(k),tb(k))=Y(fb(k),tb(k))-y(k)/a(k);
Y(tb(k),fb(k))=Y(fb(k),tb(k));
end
%formation of diagonal elements
% formation of the off diagonal matrix
for m=1:nbus
for n=1:nbranch
if fb(n)==m
Y(m,m)=Y(m,m)+ y(n)/(a(n)^2)+b(n);
elseif tb(n)==m
Y(m,m)=Y(m,m)+ y(n)+b(n);
end
end
end

%Type 2
function linedata=linedatas(num)
% frombus, tobus, R, X, B/2, tap
linedata = [1 2 0.0 0.3 0.15 1
1 3 0.0 0.3 0.15 1
3 4 0.0 0.1 0.2 1
2 4 0.0 0.1 0.2 1];
num=4;
linedata=linedatas(num);
fb=linedata(:,1);
tb=linedata(:,2);
r=linedata(:,3);
x=linedata(:,4);
b=linedata(:,5);
a=linedata(:,6);
z=r+i*x;
y=1./z;
b=i*b;
nbus=max(max(fb),max(tb)); %no of buses
nbranch=length(fb); % no of branches
Y=zeros(nbus,nbus); % initialise Ybus
% formation of off diagonal elements...
for k=1:nbranch
Y(fb(k),tb(k))=Y(fb(k),tb(k))-y(k)/a(k);
Y(tb(k),fb(k))=Y(fb(k),tb(k));
end
%formation of diagonal elements
% formation of the off diagonal matrix
for m=1:nbus
for n=1:nbranch
if fb(n)==m
Y(m,m)=Y(m,m)+ y(n)/(a(n)^2)+b(n);
elseif tb(n)==m
Y(m,m)=Y(m,m)+ y(n)+b(n);
end
end
end
Y %bud admittance matrix

%Z bus
