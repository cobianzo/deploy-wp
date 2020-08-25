# deploy-wp
Usage   
- place this file in the folder where you want to install your wp
-  edit the script replacing the values of the constants:
  - user='root'
  - pass='youirpass'
  - host='localhost'
  - locahost_path='/Users/yourpath-to-sites'
  - localhost_url='http://localhost'  

  
Example  
sh deploy-wp.sh <git@repo.git>

```sh deploy-wp.sh git@bitbucket.org:cobianzoandguest/balconi-di-piero-wp.git -locale en_GB```

**options:**  
-locale  
-db  
-prefix  

# How it works    
This is made for WP projects with  
- the repo in wp-content.
- a subfolder in `wp-content/db` with the latest db .sql
- the script `loadlatestdb.sh` in wp-content/
 
