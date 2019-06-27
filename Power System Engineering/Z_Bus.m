clc;
clear all;
nbus=input('Enter the total number of buses excluding the reference bus :
');
zbus=zeros(nbus,nbus);
t=1;
while t==1
s=menu('Specify the case number','Connect a new bus to reference
bus','connect a new bus to old bus','connect two old buses','connect an
old bus to reference bus','Quit');
switch(s);
case(1)
zb=input ('Enter the Zbus value : ');
zbus=zb;
case (2)
n=input ('Enter the second bus number : ');
zb=input('Enter the reactance value : ');
for i=1:n
if i==n
zbus(n,n)=zbus(n-1,n-1)+zb;
else
zbus(i,n)=zbus(i,n-1);
zbus(n,i)=zbus(n-1,i);
end
end
case(3)
l=input('Enter the existing bus number 1: ');
n=input('Enter the existing bus number 2: ');
zb=input('Enter the reactance value: ');
n=n+1;
for i=1:n
if i==n
zbus(n,n)=zbus(1,1)+zb+zbus(n-1,n-1)-(2*zbus(1,n-1));
zbus(n,n);
else
zbus(i,n)=zbus(1,i)-zbus(i,n-1);
zbus(i,n);
zbus(n,i)=zbus(i,n);
end
end
for i=1:nbus
for j=1:nbus
if i==j
zbus(i,j)=zbus(i,j)-(zbus(i,n)*zbus(n,j)/zbus(n,n));
zbus(j,i)=zbus(i,j);
zbus(i,j)=zbus(j,i);
else
zbus(i,j)=zbus(i,j)-(zbus(i,n)*zbus(n,j)/zbus(n,n));
end
end
end
zbus(i,n)=0;
zbus(n,i)=0;
case(4)
n=input('Enter the bus number: ');
zb=input('Enter reactance value:');
n=n+1;
for i=1:n
if i==n
zbus(n,n)=zbus(n-1,n-1)+zb;
else
zbus(i,n)=zbus(i,n-1);
zbus(n,i)=zbus(n-1,i);
end
end
for i=1:n
for j=1:n
if i==j
zbus(i,j)=zbus(i,j)-(zbus(i,n)*zbus(n,j)/zbus(n,n));
zbus(j,i)=zbus(i,j);
zbus(i,j)=zbus(j,i);
else
zbus(i,j)=zbus(i,j)-(zbus(i,n)*zbus(n,j)/zbus(n,n));
end
end
end
case(5)
disp('End the program');
choice=menu('print or end?','print','end');
if choice==1
zbus
t=0;
end
end
end