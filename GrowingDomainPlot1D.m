clf;
%close all;
M = load('lin5and50T3e2.csv');
M(:,1:2)=[];
%[X,Y] = meshgrid(linspace(1,3002,2000),linspace(1,500,500));
%M = interp2(M,X,Y);

I = imagesc(flipud(M'));

L=120*10;
TEnd=3e2;
s=9/TEnd;
%TEnd = 1e4;TEnd=19/s;
%TEnd=log(30)/s;

%TEnd=1e3;
%TEnd=(30-1)/s;

%f = @(t)exp(t*s*TEnd)/30;
%w=4*pi;fs=2/3;
f = @(t)(1+s*t*TEnd)/10;
%f = @(t)1;
%f = @(t)(1+(1+tanh(s*(t*TEnd-TEnd/2))))/3;
%f = @(t)(1+fs*sin(w*t))/(1+fs);
%inversefn = @(c,unused) [c(:,1).*f((c(:,2)-c(1,2))./((c(end,2))-(c(1,2)))),c(:,2)];
inversefn = @(c,unused) [c(:,1)./f((flip(c(:,2))-c(1,2))./((c(end,2))-(c(1,2)))),c(:,2)];
%forwardfn = @(c,unused) [sqrt(c(:,1)),c(:,2).^2];

%T = geometricTransform2d(inversefn);

T = maketform('custom',2,2,[],inversefn,[]);

UV = imtransform(I.CData,T,'XData',[0,size(M,1)],'YData',[0,size(M,2)]);
%figure
UV(UV==0)=min(min(UV))-0.01;
imagesc(UV);

%L=round(f(1))*L;
ax = gca;
ax.XTick = [0, round(size(M,1)/2), size(M,1)];
ax.XTickLabel = {'0', round(L/2),L};
ax.YTick = [1, round(size(M,2)/2), size(M,2)];
ax.YTickLabel = {num2str(round(TEnd)),num2str(round(TEnd/2)),'0'};
%ax.YTick = ax.YTick-(ax.YTick(2)-ax.YTick(1)-1);
xlabel('$x$','interpreter','latex');
ylabel('$t$','interpreter','latex');
colorbar;
set(ax,'FontSize',20);
cmap = parula(2056*10);
cmap(1,:)=ones(3,1);
colormap(cmap);
%h = caxis;
%caxis([h(1),0.7]);