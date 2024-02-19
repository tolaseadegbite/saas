// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import "./src/jquery"
import "jquery-ui"

document.addEventListener('turbo:load', () => { 
    $(".sidebar ul li").on('click', function () {
        $(".sidebar ul li.active").removeClass('active');
        $(this).addClass('active');
    });
    
    $('.open-btn').on('click', function () {
        $('.sidebar').addClass('active');
    
    });
    
    
    $('.close-btn').on('click', function () {
        $('.sidebar').removeClass('active');
    
    })
 })
