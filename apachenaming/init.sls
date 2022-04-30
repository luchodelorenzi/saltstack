
######################################################
# install apache webserver in centos, start service, changePage
# 
###################################################### 
#install apache
apache-pkg:
  pkg:
    - installed
    - name: httpd
  service:
    - running 
    - name: httpd
    - require:
      - pkg: apache-pkg
      
#change page
change_page:
  cmd.run:
    - name: sed -i "s/Testing 123/$HOSTNAME/g" /usr/share/httpd/noindex/index.html
    - require:
      - apache-pkg
      
