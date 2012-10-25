/**
 * Converts an RGB color value to HSV. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSV_color_space.
 * Assumes r, g, and b are contained in the set [0, 255] and
 * returns h, s, and v in the set [0, 1].
 *
 * @param   Number  r       The red color value
 * @param   Number  g       The green color value
 * @param   Number  b       The blue color value
 * @return  Array           The HSV representation
 */
function rgbToHsv(r, g, b){
    r = r/255, g = g/255, b = b/255;
    var max = Math.max(r, g, b), min = Math.min(r, g, b);
    var h, s, v = max;

    var d = max - min;
    s = max == 0 ? 0 : d / max;

    if(max == min){
        h = 0; // achromatic
    }else{
        switch(max){
            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
            case g: h = (b - r) / d + 2; break;
            case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
    }

    return [h * 360, s * 100, v * 100];
}
/**
 * Converts an RGB color value to Hexidecimal.
 * Assumes r, g, and b are contained in the set [0, 255] and
 * returns hexidecimal value including # for css parsing.
 *
 * @param   Number  r       The red color value
 * @param   Number  g       The green color value
 * @param   Number  b       The blue color value
 * @return  Array           The HSV representation
 */
function rgbToHex(r, g, b){
    r = parseInt(r, 10);
    g = parseInt(g, 10);
    b = parseInt(b, 10);
    //verify input values are properly entered
    if(r >= 0 && g >= 0  && b >= 0 && r <= 255 && g <= 255 && g <= 255){
        //prepend a 0 if the hex value will be a single character (ie. F wil need to be 0F in the hex color display)
        if(r <= 15) r = "0" + r.toString(16);
        else r = r.toString(16);
        if(g <= 15) g = "0" + g.toString(16);
        else g = g.toString(16);
        if(b <= 15) b = "0" + b.toString(16);
        else b = b.toString(16);
        //concatenate hex values)
        return "#" + r + g + b;
    }
    else alert("invalid rgb value!");
}
/**
 * Converts an HSV color value to RGB. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSV_color_space.
 * Assumes h, s, and v are contained in the set [0, 1] and
 * returns r, g, and b in the set [0, 255].
 *
 * @param   Number  h       The hue
 * @param   Number  s       The saturation
 * @param   Number  v       The value
 * @return  Array           The RGB representation
 */
function hsvToRgb(h, s, v){
    var r, g, b;
    h = h/360;
    s = s/100;
    v = v/100;
    var i = Math.floor(h * 6);
    var f = h * 6 - i;
    var p = v * (1 - s);
    var q = v * (1 - f * s);
    var t = v * (1 - (1 - f) * s);

    switch(i % 6){
        case 0: r = v, g = t, b = p; break;
        case 1: r = q, g = v, b = p; break;
        case 2: r = p, g = v, b = t; break;
        case 3: r = p, g = q, b = v; break;
        case 4: r = t, g = p, b = v; break;
        case 5: r = v, g = p, b = q; break;
    }
    return [r * 255, g * 255, b * 255];
}

function hexToRgb(hex){
    var r, g, b;
    if(hex.length == 3){
        r = parseInt(hex.substr(0,1),16);
        g = parseInt(hex.substr(1,1),16);
        b = parseInt(hex.substr(2,1),16);
    }
    else if(hex.length == 4){
        r = parseInt(hex.substr(1,2),16);
        g = parseInt(hex.substr(3,2),16);
        b = parseInt(hex.substr(5,2),16);
    }
    else if(hex.length == 6){
        r = parseInt(hex.substr(0,2),16);
        g = parseInt(hex.substr(2,2),16);
        b = parseInt(hex.substr(4,2),16);
    }
    else if(hex.length == 7){
        r = parseInt(hex.substr(1,2),16);
        g = parseInt(hex.substr(3,2),16);
        b = parseInt(hex.substr(5,2),16);
    }
    else alert("invalid hex string!");
    return[r, g, b];
}
function hsvToHex(h, s, v){
    var rgb = hsvToRgb(h,s,v);
    return rgbToHex(rgb[0],rgb[1],rgb[2]);
}
function hexToHsv(hex){
    var rgb = hexToRgb(hex);
    return rgbToHsv(rgb[0],[1],[2]);
}
