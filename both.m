format long
usernum=featMat(:,1);
feature=featMat(:,3:12);
feature=[feature featMat(:,14:34)];%提取出除了用户ID，文章ID，手机ID以外的所有内容赋值为feature
feature=mapminmax(feature);
q=[];
jiange=[];
leastnum=[];
for i=1:21158
%     for j=1:31
        if (max(abs(feature(i,:))<0.001)||max(isnan(feature(i,:)))==1)
            q=[q i];
        end
    end
% end
feature(q(:),:)=[];
usernum(q(:),:)=[];
len=length(feature);
m=0;
for i=1:len-1
    
    if(usernum(i)~=usernum(i+1))
        jiange=[jiange;i+1];
        leastnum=[leastnum;m];
        m=0;
    else
        m=m+1;
    end
end
jiange=[1;jiange];
for i=1:41
    num=jiange(i);
    b(:,:,i)=feature(num:num+159,:);
    user(i,:)=usernum(num,:);
end

temp=0;
for i=1:1:41
    for j=1:31
        for k=1:100
            temp=temp+sum(b(k,j,i));
        end
        means(i,j)=temp/100;
        temp=0;
    end
end
%**************方法1************%******%******%******%******%******%******%******%******%******%******%******%******%******%******%******%**%******%******%**%******%******%**%******%******%
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:1:41
%     for j=1:1:41
%         if i==j
%             for m=1:1:60
%                 userscore(i,m)=norm((b(m+100,:,i)-means(i,:)))^2;
%             end
%         else
%             for k=1:1:5
%                 imposterscore(j,k,i)=norm((b(k,:,j)-means(j,:)))^2;
%             end
%         end
%     end
% end
% 
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% jieguo=zeros(51,1);
% for q=1:20
% for yuzhi=0+0.01*q:0.05:2.3*q
%     for i=1:41
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:40
%             for j=1:5
%                 for m=1:60
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%         falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%         nn=zeros(40,5);np=zeros(40,5);
%         pn=zeros(1,60);pp=zeros(1,60);
%     end
% end
% len1=length(hitrate(:));
% for i=1:len1
%     if (abs(1-hitrate(i)-falserate(i))<0.05)
%         equal=[equal falserate(i)];
%     end
%     if((1-hitrate(i))<0.05)
%         onehit=[onehit falserate(i)];
%     end
% end
%       
% 
% equalrate=[equalrate min(equal(:))];
% zeromiss=[zeromiss min(onehit(:))];
% fprintf('%d',q)
% end


% % %**************方法2************%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%**%******%******%**%******%******%
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:41
%     for j=1:41
%         if i==j
%             for m=1:60
%                 userscore(i,m)=norm(((b(m+100,:,i)-means(i,:))).^2)/(norm((means(i,:)))*norm(b(m+100,:,i)));
%             end
%         else
%             for k=1:1:5
%                 imposterscore(j,k,i)=norm(((b(k,:,j)-means(j,:))).^2)/(norm((means(j,:)))*norm(b(k,:,j)));
%             end
%         end
%     end
% end
% 
% 
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
% for yuzhi=0+0.0005*q:0.01:0.3+q*0.05
%     for i=1:41
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:40
%             for j=1:5
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%         falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%         nn=zeros(40,5);np=zeros(40,5);
%         pn=zeros(1,60);pp=zeros(1,60);
%     end
% end
% len1=length(hitrate(:));
% for i=1:len1
%     if (abs(1-hitrate(i)-falserate(i))<0.05)
%         equal=[equal falserate(i)];
%     end
%     if((1-hitrate(i))<0.05)
%         onehit=[onehit falserate(i)];
%     end
% end
%       
% if (q<20)
% equalrate=[equalrate min(equal(:))];
% zeromiss=[zeromiss min(onehit(:))];
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% else
%    equalrate=[equalrate min(equal(:))];
% zeromiss=[zeromiss min(onehit(:))];
% end
% 
% fprintf('%d',q)
% end
% % %**************方法2************%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%**%******%******%**%******%******%



%**************方法3************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:1:41
%     for j=1:1:41
%         if i==j
%             for m=1:1:60
%                 userscore(i,m)=sum(abs((b(m+100,:,i)-means(i,:))));
%             end
%         else
%             for k=1:1:5
%                 imposterscore(j,k,i)=sum(abs((b(k,:,j)-means(j,:))));
%             end
%         end
%     end
% end
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0.5+0.05*q:0.1:5+1*q
%     for i=1:41
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:40
%             for j=1:5
%                 for m=1:60
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%         falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%         nn=zeros(40,5);np=zeros(40,5);
%         pn=zeros(1,60);pp=zeros(1,60);
%     end
% end
% len1=length(hitrate(:));
% for i=1:len1
%     if (abs(1-hitrate(i)-falserate(i))<0.05)
%         equal=[equal falserate(i)];
%     end
%     if((1-hitrate(i))<0.05)
%         onehit=[onehit falserate(i)];
%     end
% end
%       
% if(q<20)
% equalrate=[equalrate min(equal(:))];
% zeromiss=[zeromiss min(onehit(:))];
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% else
% equalrate=[equalrate min(equal(:))];
% zeromiss=[zeromiss min(onehit(:))];
% end
% fprintf('%d',q)
% end
%**************方法3************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%


%**************方法4************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% sbias=zeros(41,31);
% for i=1:41
%     for j=1:31
%         for k=1:100
%             sbias(i,j)=sbias(i,j)+(b(k,j,i)-means(i,j)).^2;
%         end
%     end
% end
% for i=1:41
%     for j=1:31
%         sbias(i,j)=sqrt(sbias(i,j)/100);
%     end
% end
% rmeans=zeros(41,31);
% c=zeros(100,31,41);
% for i=1:41
%     for j=1:31
%         for k=1:100
%         if(means(i,j)-b(k,j,i))<(3*sbias(i,j))
%             c(k,j,i)=b(k,j,i);
%         end
%         end
%     end
% end
% for i=1:41
%     for j=1:31
%         if nnz(c(:,j,i)~=0)
%             rmeans(i,j)=sum(c(:,j,i))/nnz(c(:,j,i));
%         end
%     end
% end
% for i=1:1:41
%     for j=1:1:41
%         if i==j
%             for m=1:60
%                 a=abs(b(m+100,:,i)-rmeans(i,:));
%                 userscore(i,m)=sum(a(:));
%             end
%         else
%             for k=1:1:5
%                 a=abs(b(k,:,j)-rmeans(j,:));
%                 imposterscore(j,k,i)=sum(a(:));
%             end
%         end
%     end
% end
% 
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0.5+0.05*q:0.1:5+1*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end

%**************方法4************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%




%**************方法5************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% mabias=zeros(41,31);
% for i=1:41
%     for j=1:31
%         for k=1:100
%             mabias(i,j)=mabias(i,j)+(abs((b(k,j,i)-means(i,j))));
%         end
%     end
% end
% for i=1:41
%     for j=1:31
%         mabias(i,j)=(mabias(i,j)/100);
%     end
% end
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:1:41
%     for j=1:1:41
%         if i==j
%             for m=1:60
%                 for n=1:31
%                     if (mabias(i,n)~=0)
%                         a=abs(b(m+100,n,i)-means(i,n));
%                         userscore(i,m)=userscore(i,m)+a/mabias(i,n);
%                     end
%                 end
%             end
%         else
%             for k=1:1:5
%                 for n=1:31
%                     if (mabias(i,n)~=0)
%                         a=abs(b(k,n,j)-means(i,n));
%                         imposterscore(j,k,i)=imposterscore(j,k,i)+a/mabias(i,n);
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=2+0.1*q:0.5:100+5*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];      
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end
%**************方法5************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%




%**************方法6************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% % c=b(1:100,:,:);
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% % for i=1:41
% %     %     for m=1:60
% %     C(:,:,i)=cov(c(:,:,i));             %S(q,w,m,i)={[His1(i)-means(i)]*[His1(j)-u(j)]+[His2(i)-u(i)]*[His2(j)-u(j)]}/2       [means(i,:);b(m+100,:,i)]
% % end
% c=[];
% for i=1:41
%     c=[c;b(:,:,i)];
% end
% C=cov(c);
% % end
% % for i=1:41
% %     for j=1:41
% %     for k=1:5
% %     D(:,:,k,j,i)=cov([b(k,:,j);means(i,:)]);
% %     end
% %     end
% % end
% 
% for i=1:41
%     for j=1:41
%         if i==j
%             for m=1:60
%                 userscore(i,m)=(b(m+100,:,i)-means(i,:))*inv(C)*((b(m+100,:,i))-means(i,:))';
%                 
%             end
%         else
%             for k=1:1:5
%                 imposterscore(j,k,i)=(b(k,:,j)-means(i,:))*inv(C)*((b(k,:,j))-means(i,:))';%mahal(b(k,:,i)',means(j,:)')%mahal(b(k,:,j),c(:,:,i));
%             end
%         end
%     end
% end
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0.5+0.2*q:0.1:20+4*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];      
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end


%**************方法6************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法7************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% c=[];
% for i=1:41
%     c=[c;b(:,:,i)];
% end
% C=cov(c);
% for i=1:1:41
%     for j=1:1:41
%         
%         if i==j
%             for m=1:1:60
%                 userscore(i,m)=((b(m+100,:,i)-means(i,:))*pinv(C)*((b(m+100,:,i)-means(i,:)))')/(norm((means(i,:)))*norm(b(m+100,:,i)));
%             end
%         else
%             for k=1:1:5
%                 imposterscore(j,k,i)=(b(k,:,j)-means(i,:))*pinv(C)*((b(k,:,j)-means(i,:)))'/(norm((means(i,:)))*norm(b(k,:,j)));
%             end
%         end
%     end
% end
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0.1+0.05*q:0.1:5+2*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end


%**************方法7************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法8************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% c=[];
% for i=1:41
%     c=[c;b(:,:,i)];
% end
% C=cov(c);
% for i=1:41
%     for j=1:41
%         
%             if i==j
%                 for m=1:100
%                     for n=1:60
%                         user1(m,n,i)=(b(m,:,i)-b(n+100,:,i))*pinv(C)*(b(m,:,i)-b(n+100,:,i))';
%                     end
%                 end
%             else
%                 for k=1:5
%                 for m=1:100
%                     imposter(j,m,k,i)=(b(m,:,i)-b(k,:,j))*pinv(C)*(b(m,:,i)-b(k,:,j))';
%                 end
%             end
%         end
%     end
% end
% 
% for i=1:41
%     for n=1:60
%         userscore(i,n)=min(user1(:,n,i));
%     end
% end
% for i=1:41
%     for j=1:41
%         for k=1:5
%             imposterscore(j,k,i)=min(imposter(j,:,k,i));
%         end
%     end
% end
% 
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0+0.001*q:0.01:0.05+0.5*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end


%**************方法8************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%





%**************方法9************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=[];
% for i=1:41
%     c=[c;b(1:100,:,i)];
% end
% 
% for i=1:41
%     output=-1*ones(4100,1);
%     output((i-1)*100+1:i*100,1)=1;
%     [inputn,inputps]=mapminmax(c');
%     net = newff( inputn,output',10);
%     [m1,n1]=size(net.IW{1,1});
%     net.IW{1,1}=0.1*ones(m1,n1);
%     [m2,n2]=size(net.LW{2,1});
%     net.LW{2,1}=0.1*ones(m2,n2);
%     net.trainparam.epochs = 500 ;
%     net.trainparam.goal = 0.01 ;
%     net.trainParam.lr = 0.0001 ;
%     net.biases{1,1}.initFcn = 'rands';
%     net.biases{2,1}.initFcn = 'rands';
%     net = init(net);
%     onehit=[];
%     hit=[];
%     %开始训练
%     net = train(net, inputn, output') ;
%     for j=1:41
%         if i==j
%             inputn_test=mapminmax('apply',b(101:160,:,i)',inputps);
%             BPoutput=sim(net,inputn_test);
%             for m=1:60
%                 userscore(i,m)=BPoutput(:,m);
%             end
%         else
%             inputn_test=mapminmax('apply',b(1:5,:,j)',inputps);
%             BPoutput=sim(net,inputn_test);
%             for k=1:5
%                 imposterscore(j,k,i)=BPoutput(:,k);
%             end
%         end
%     end
% end

% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=-1-0.001*q:0.01:1-0.001*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end
       
%**************方法9************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法10************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
c=[];
for i=1:41
    c=[c;b(1:100,:,i)];
end

for i=1:41
    output=-1*ones(4100,1);
    output((i-1)*100+1:i*100,1)=1;
    [inputn,inputps]=mapminmax(c');


    net = newff( inputn,output',31);
    [m1,n1]=size(net.IW{1,1});
    net.IW{1,1}=0.1*ones(m1,n1);
    [m2,n2]=size(net.LW{2,1});
    net.LW{2,1}=0.1*ones(m2,n2);
    net.trainparam.epochs = 500 ;
    net.trainparam.goal = 0.01 ;
    net.trainParam.lr = 0.0001 ;
    net.trainParam.mc = 0.0003 ;
    net.biases{1,1}.initFcn = 'rands';
    net.biases{2,1}.initFcn = 'rands';
    net = init(net);
    onehit=[];
    hit=[];
    %开始训练
    net = train( net, inputn , output' );
    for j=1:41
        if i==j
            for m=1:60
                inputn_test=mapminmax('apply',b(100+m,:,i)',inputps);
                BPoutput=sim(net,inputn_test);
                userscore(i,m)=norm(BPoutput(:,:)'-b(100+m,:,i));
            end
        else
            for k=1:5
                inputn_test=mapminmax('apply',b(k,:,j)',inputps);
                BPoutput=sim(net,inputn_test);
                imposterscore(j,k,i)=norm(BPoutput(:,:)'-b(k,:,j));
            end
        end
    end
end

hitrate=[];
falserate=[];
equal=[];
onehit=[];
equalrate=[];
zeromiss=[];
nn=zeros(40,5);np=zeros(40,5);
pn=zeros(1,60);pp=zeros(1,60);
for q=1:20
    for yuzhi=1+0.02*q:0.1:9+0.1*q
        for i=1:41
            iposterscore=imposterscore(:,:,i);
            iposterscore(i,:)=[];
            for k=1:40
                
                for m=1:60
                    if(userscore(i,m)>=yuzhi)
                        pn(1,m)=1;
                    else pp(1,m)=1;
                    end
                end
                for j=1:5
                    if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
                        nn(k,j)=1;
                    else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
                            np(k,j)=1;
                        end
                    end
                end
            end
            hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
            falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
            nn=zeros(40,5);np=zeros(40,5);
            pn=zeros(1,60);pp=zeros(1,60);
        end
    end
    len1=length(hitrate(:));
    for i=1:len1
        if (abs(1-hitrate(i)-falserate(i))<0.05)
            equal=[equal falserate(i)];
        end
        if((1-hitrate(i))<0.05)
            onehit=[onehit falserate(i)];
        end
    end
    
    if(q<20)
        equalrate=[equalrate min(equal(:))];
        zeromiss=[zeromiss min(onehit(:))];
        hitrate=[];
        falserate=[];
        equal=[];
        onehit=[];
    else
        equalrate=[equalrate min(equal(:))];
        zeromiss=[zeromiss min(onehit(:))];
    end
    fprintf('%d',q)
end
%**************方法10************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法11************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%

%**************方法11************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%


%**************方法12************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:100,:,:);
% zscoreu=zeros(60,31,41);
% zscorei=zeros(41,5,31,41);
% for i=1:41
%     C(i,:)=std(c(:,:,i));
% end
% for i=1:41
%     for m=1:60
%         for q=1:31
%             if C(i,q)~=0
%                 zscoreu(m,q,i)=abs((b(m+100,q,i)-means(i,q)))/C(i,q);
%             end
%         end
%     end
% end
% for i=1:41
%     for j=1:41
%         if i~=j
%             for k=1:5
%                 for q=1:31
%                     if C(i,q)~=0
%                         zscorei(j,k,q,i)=abs((b(k,q,j)-means(i,q)))/C(i,q);
%                     end
%                 end
%             end
%         end
%     end
% end
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:41
%     for j=1:41
%         if i==j
%             for m=1:1:60
%                 for q=1:31
%                     if zscoreu(m,q,i)>0.9
%                         userscore(i,m)=userscore(i,m)+1;
%                     else
%                         userscore(i,m)=userscore(i,m);
%                     end
%                 end
%             end
%         else
%             for k=1:5
%                 for q=1:31
%                     if zscorei(j,k,q,i)>0.9
%                         imposterscore(j,k,i)=imposterscore(j,k,i)+1;
%                     else
%                         imposterscore(j,k,i)=imposterscore(j,k,i);
%                     end
%                 end
%             end
%         end
%     end
% end
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0:1:25+0.25*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end
%**************方法12************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%


%**************方法13************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=[];
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:41
%     c=[c;b(1:100,:,i)];
% end
% train_data=c;
% for i=1:41
%     for j=1:41
%         lable=-1*ones(4100,1);
%         lable((i-1)*100+1:i*100,1)=1;
%         model = svmtrain(lable, train_data ,'-s 2');
%         
%         if i==j
%             test_lable=ones(60,1);
%             test_data=b(101:160,:,i);
%             [predicted_label, accuracy, decision_values] = svmpredict(test_lable, test_data, model);
%              userscore(i,:)=(abs(decision_values(:)))';
%         else
%             test_lable=-1*ones(5,1);
%             test_data=b(1:5,:,j);
%             [predicted_label, accuracy, decision_values] = svmpredict(test_lable, test_data, model);
%             imposterscore(j,:,i)=(abs(decision_values(:)))';
%         end
%     end
% end
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=0+0.2*q:0.5:15+20*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end






%**************方法13************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%




%**************方法14************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:100,:,:);
% X=zeros(100,31);
% userscore=zeros(41,60);
% imposterscore=zeros(41,5,41);
% for i=1:41
%     for j=1:41
%         X=b(1:100,:,i);
%         %         opts = statset('Display','final');
%         [IDX,C,sumd,D] = kmeans(X',3);%,'Distance','city','Replicates',3,'Options',opts);
%         D=D';
%         if i==j
%             for m=1:60
%                 user1(1)=norm(b(m+100,:,i)-D(1,:));
%                 user1(2)=norm(b(m+100,:,i)-D(2,:));
%                 user1(3)=norm(b(m+100,:,i)-D(3,:));
%                 userscore(i,m)=min(user1(:));
%             end
%         else
%             for k=1:5
%                 imposter(1)=norm(b(k,:,i)-D(1,:));
%                 imposter(2)=norm(b(k,:,i)-D(2,:));
%                 imposter(3)=norm(b(k,:,i)-D(3,:));
%                 imposterscore(j,k,i)=min(imposter(:));
%             end
%         end
%     end
% end
% hitrate=[];
% falserate=[];
% equal=[];
% onehit=[];
% equalrate=[];
% zeromiss=[];
% nn=zeros(40,5);np=zeros(40,5);
% pn=zeros(1,60);pp=zeros(1,60);
% for q=1:20
%     for yuzhi=180+1*q:0.5:280+1*q
%         for i=1:41
%             iposterscore=imposterscore(:,:,i);
%             iposterscore(i,:)=[];
%             for k=1:40
%                 
%                 for m=1:60
%                     if(userscore(i,m)>=yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 for j=1:5
%                     if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                         nn(k,j)=1;
%                     else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                             np(k,j)=1;
%                         end
%                     end
%                 end
%             end
%             hitrate=[hitrate (sum(nn(:)))/(sum(np(:))+sum(nn(:)))];
%             falserate=[falserate (sum(pn(:)))/(sum(pn(:))+sum(pp(:)))];
%             nn=zeros(40,5);np=zeros(40,5);
%             pn=zeros(1,60);pp=zeros(1,60);
%         end
%     end
%     len1=length(hitrate(:));
%     for i=1:len1
%         if (abs(1-hitrate(i)-falserate(i))<0.05)
%             equal=[equal falserate(i)];
%         end
%         if((1-hitrate(i))<0.05)
%             onehit=[onehit falserate(i)];
%         end
%     end
%     
%     if(q<20)
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%         hitrate=[];
%         falserate=[];
%         equal=[];
%         onehit=[];
%     else
%         equalrate=[equalrate min(equal(:))];
%         zeromiss=[zeromiss min(onehit(:))];
%     end
%     fprintf('%d',q)
% end
