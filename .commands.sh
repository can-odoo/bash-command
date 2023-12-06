#!/bin/bash

# TODO: gt command conflicts with genometools, find unique command
# Command 'gt' not found, but can be installed with:
#sudo apt install genometools

# $1 $2 are positional args
# Create custom bash command: [1]
# After creating command file need to mention it on '.bashrc' file
# now you just need to run `runme.sh` file and util commands will be added


# global color variable
Green='\033[0;32m'
NC='\033[0m' # No Color (Resets color to default)

# Depending on your file path change the 'cd <odoo_module_path>'
# go to odoo/odoo_version/
function odv() {
    cd ;
    cd odoo/odoo_version/$1/community;
}

# git branch
function gb() {
    git branch
}

# git checkout <branch>
function gc() {
    git checkout $1
}

# git fetch, pull
function gp() {
    git pull;
    echo -e "${Green}git pull ${NC}";
}

# git fetch, pull
function gpll() {
    git fetch --all;
    echo -e "${Green}[success] git fetch --all ${NC}";

    git fetch --all -p;
    echo -e "${Green}[success] git fetch --all -p ${NC}";

    git pull;
    echo -e "${Green}[success] git pull ${NC}";
}

# connect to odoo-server
function obin() {
    # $1 - database name -> default is test
    # $2 - moule_name
    # $3 - port -> default is 8069

    # print command in terminal
    echo -e "${Green}./odoo-bin --addons-path=addons/,../enterprise -d ${1:-test} --xmlrpc-port ${2:-8069} --dev=all $3 ${NC}";
    echo -e "${Green}\e]8;;http://localhost:${2:-8069}/web/login\alocalhost:${2:-8069}\e]8;;\a ${NC}";

    # command execute
    ./odoo-bin --addons-path=addons/,../enterprise -d ${1:-test} --xmlrpc-port ${2:-8069} --dev=all $3;
}

function otheme() {

    # use the default name or provided by user 
    dir_name=${1:-website_theme}
    # mkdir website_theme

    mkdir "$dir_name"

    # go to current directory
    cd "$dir_name"

    # making odoo standard structure
    mkdir data  # Presets, menus, pages, images, shapes, … (*.xml)
    mkdir i18n  # Translations (*.po, *.pot)
    mkdir lib  # External libraries (*.js)
    mkdir static
    mkdir views  # Custom views and templates (*.xml)

    # __manifest__ file
    touch __manifest__.py
    echo "# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.
{
    'name': '$dir_name',
    'description': '...',
    'category': 'Website/Theme',
    'version': '16.0.0',
    'author': 'Odoo',
    'license': '...',
    'depends': ['website'],
    'data': [
        'data/presets.xml',
        'data/menu.xml',
        'data/pages/about_us.xml',
        'data/pages/page_not_found_404.xml',
    ],
    'assets': {
        'web._assets_primary_variables': [
            '$dir_name/static/src/scss/primary_variables.scss',
        ],
        'web._assets_frontend_helpers': [
            ('prepend', '$dir_name/static/src/scss/bootstrap_overriden.scss'),
        ],
        'web.assests_frontend': [
            #'$dir_name/static/src/scss/theme.scss',
            # Interactivity, js files
            # '$dir_name/static/src/js/theme.js',
        ],
    },
}
" > __manifest__.py

    # __init__ file
    touch __init__.py

    # data files
    cd data

    # presets: active and deactive default stuffs like header, footer, change
    # logo img, no copyright, etc.
    touch presets.xml
    echo '<?xml version="1.0" encoding="UTF-8"?>
<odoo>
    <!-- HEADER -->
    <!-- ======================================= -->

    <!-- deactivating default header  -->
    <record id="website.template_header_default" model="ir.ui.view">
        <field name="active" eval="False"/>   
    </record>

    <!-- activat contact header  -->
    <record id="website.template_header_search" model="ir.ui.view">
        <field name="active" eval="True"/>
     </record>

    <!-- FOOTER -->
    <!-- ======================================= -->
    
    <!-- deactivate default footer -->
    <record id="website.footer_custom" model="ir.ui.view">
        <field name="active" eval="False"/>
    </record>
    <record id="website.template_footer_contact" model="ir.ui.view">
        <field name="active" eval="True" />
    </record>

    <!-- No Copyright -->
    <!-- <record id="website.footer_no_copyright" model="ir.ui.view">
        <field name="active" eval="True"/>        
    </record> -->
</odoo>
' > presets.xml

    # menu: delete default menu (home, shop, Contact us, Mega Menu etc.),
    #       create new menu, mega menu dropdown etc
    touch menu.xml
    echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<odoo>

    <!-- Delete Default 'Home' item -->
    <delete model=\"website.menu\" search=\"[('url','in', ['/', '/']), ('website_id', '=', 1)]\"/>

    <!-- Delete Default 'Contact us' item -->
    <!-- <delete model=\"website.menu\" search=\"[('url','in', ['/', '/contactus']), ('website_id', '=', 1)]\"/> -->

    <!-- Delete Default 'Shop' item -->
    <!-- <delete model=\"website.menu\" search=\"[('url','in', ['/', '/shop']), ('website_id', '=', 1)]\"/> -->

    <!-- Delete Default 'Blog' item -->
    <!-- <delete model=\"website.menu\" search=\"[('url','in', ['/', '/blog']), ('website_id', '=', 1)]\"/> -->

    <!-- Delete Default 'Mega Menu item -->
    <!-- <delete model=\"website.menu\" search=\"[('url','in', ['/', '/#']), ('website_id', '=', 1)]\"/> -->

</odoo>

<!-- 
    ref_theme: https://www.odoo.com/documentation/master/developer/howtos/website_themes/navigation.html
-->
" > menu.xml


    # directory for different pages Home, About mega menu etc.
    mkdir pages
    cd pages

    touch about_us.xml
    echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<odoo>

    <!-- Creating About Us Menu -->
    <record id=\"menu_about_us\" model=\"website.menu\">
        <field name=\"name\">About us</field>
        <field name=\"url\">/about-us</field>
        <field name=\"parent_id\" search=\"[
            ('url', '=', '/default-main-menu'),
            ('website_id', '=', 1)]\"/>
        <field name=\"website_id\">1</field>
        <field name=\"sequence\" type=\"int\">10</field>
    </record>
</odoo>
" > about_us.xml

    touch page_not_found_404.xml
    echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<odoo>

    <template id=\"404\" inherit_id=\"http_routing.404\">
        <xpath expr=\"//div[hasclass('oe_structure')]\" position=\"replace\">

            <!-- Title -->
            <t t-set=\"additional_title\" t-value=\"'404 - Page not found'\"/>

            <!-- Content -->
            <div class=\"oe_structure\">
                <section class=\"s_title\">
                    <div class=\"container\">
                        <div class=\"row\">
                            <div class=\"col-lg-12 text-center pt80 pb80\">
                                <h1 class=\"mb-0\"><span style=\"font-size: 62px;\">404</span></h1>
                                <h2 class=\"mb-5\"><font class=\"text-o-color-2\">Page not found</font></h2>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

        </xpath>
    </template>

</odoo>
" > page_not_found_404.xml


    # create sub directory
    cd ../../static
    mkdir description
    mkdir fonts

     # Shapes for images
    mkdir image_shapes

    # Shapes for background
    mkdir shapes

    # src directory
    mkdir src

    cd src
    mkdir img

    mkdir js
    mkdir scss
    mkdir snippets

    cd img
    touch website_background_img.svg
    echo "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1600 900'>
    <rect fill='#ffffff' width='1600' height='900' />
    <defs>
        <linearGradient id='a' x1='0' x2='0' y1='1' y2='0'>
            <stop offset='0' stop-color='#0FF' />
            <stop offset='1' stop-color='#CF6' />
        </linearGradient>
        <linearGradient id='b' x1='0' x2='0' y1='0' y2='1'>
            <stop offset='0' stop-color='#F00' />
            <stop offset='1' stop-color='#FC0' />
        </linearGradient>
    </defs>
    <g fill='#FFF' fill-opacity='0' stroke-miterlimit='10'>
        <g stroke='url(#a)' stroke-width='2'>
            <path transform='translate(0 0)' d='M1409 581 1450.35 511 1490 581z' />
            <circle stroke-width='4' transform='rotate(0 800 450)' cx='500' cy='100' r='40' />
            <path transform='translate(0 0)'
                d='M400.86 735.5h-83.73c0-23.12 18.74-41.87 41.87-41.87S400.86 712.38 400.86 735.5z' />
        </g>
        <g stroke='url(#b)' stroke-width='4'>
            <path transform='translate(0 0)' d='M149.8 345.2 118.4 389.8 149.8 434.4 181.2 389.8z' />
            <rect stroke-width='8' transform='rotate(0 1089 759)' x='1039' y='709' width='100'
                height='100' />
            <path transform='rotate(0 1400 132)'
                d='M1426.8 132.4 1405.7 168.8 1363.7 168.8 1342.7 132.4 1363.7 96 1405.7 96z' />
        </g>
    </g>
</svg>
" > website_background_img.svg

    cd ../scss
    touch primary_variables.scss
    echo "// Presets

\$o-website-values-palettes: (
    ( // colors
        'color-palettes-name': 'airproof',

        // backgound image for website
        'body-image': '/$dir_name/static/src/img/website_background_img.svg',

        // header template
        'header-template': 'airproof', // mention custom template that we have created
    ),
);


// ------------------------------------------------------------------------------ //
// FONTS
// ------------------------------------------------------------------------------ //

\$o-theme-font-configs: (
    'Poppins': ('family': ('Poppins', sans-serif),
        'url': 'Poppins:400,500',
        'properties' : ('base': ('font-size-base': 1rem,
            ),
        ),
    ),
);

// ------------------------------------------------------------------------------ //
// COLORS
// ------------------------------------------------------------------------------ //

\$o-color-palettes: map-merge(\$o-color-palettes,
        ('airproof': (
            'o-color-1': #bedb39,
            'o-color-2': #2c3e50,
            'o-color-3': #f2f2f2,
            'o-color-4': #ffffff,
            'o-color-5': #000000,

            // background color
            'o-cc1-bg': 'o-color-3', // if background-img set color bg-color override with img
        ),
    ),
);

// Add color theme
\$o-selected-color-palettes-names: append(\$o-selected-color-palettes-names, 'airproof');
" > primary_variables.scss

    touch bootstrap_overriden.scss

    echo "\$enable-responsive-font-sizes:      true;
" > bootstrap_overriden.scss
    
    cd
}


# ref:
# ----
# [1] https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e
