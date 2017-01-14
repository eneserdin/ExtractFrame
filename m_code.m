for ii=1:150
s=[num2str(ii) '.bmp'];
a(ii)=mean(mean(mean(imread(s))));
end
plot(a);