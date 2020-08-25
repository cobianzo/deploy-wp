#constants
user='root'
pass='yourpass'
host='localhost'
locahost_path='/Users/yourpath/Sites'
localhost_url='http://localhost'

path=$(pwd -P)
siteurl=${path/$locahost_path/$localhost_url}  # replace the base directory for the base url

# options
db=""
locale="en_GB"
prefix="wp_"

options="$@"

gitrepo=$1


set_options(){

    prev_option=""

    for option in $options;
    do
        # echo $option
        case $prev_option in
            "-locale" )
                locale=$option
            ;;
            "-db" )
                db=$option
            ;;
            "-prefix" )
                prefix=$option
            ;;

        esac

        prev_option="$option"

    done

}

function deploy()
{
    set_options

    project_name="${gitrepo##*/}"  
    project_name=${project_name/.git/} #remove .git from the name

    echo "--- Starting deploy from git project: $project_name"
    if [ -z "$db" ]; then 
        db=$project_name
        echo "* db name initialized to $db"; 
    fi
    # some info to show
    echo "* $locale "
    echo "* $db "
    echo "* $prefix "
    echo "* $siteurl"

    # All params set up. Deploy steps!
    echo "\nDownloading WP $locale"
    wp core download --locale=$locale
    echo "\nCreating wp-config WP $db. Table prefix: $prefix"
    wp config create --dbname="$db" --dbuser="$user" --dbpass="$pass" --dbhost="$host"  --dbprefix="$prefix"
    echo "\nCreating db $db"
    wp db create
    cd wp-content; rm -rf *
    git clone $gitrepo .
    wp core install --url=$siteurl --title=Example --admin_user=supervisor --admin_password=strongpassword --admin_email=info@example.com
    sh loadlatestdb.sh
    wp media regenerate --only-missing --yes  


}



deploy
