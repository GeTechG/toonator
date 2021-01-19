package com.cartogrammar.drawing;

import openfl.Vector;
import flash.errors.Error;
import fl.motion.BezierSegment;
import flash.display.Graphics;
import flash.geom.Point;

class CubicBezier
{
    
    
    public function new()
    {
    }
    
    public static function drawCurve(param1 : Graphics, param2 : Point, param3 : Point, param4 : Point, param5 : Point) : Void
    {
        var _loc8_ : Point = null;
        var _loc6_ : BezierSegment = new BezierSegment(param2, param3, param4, param5);
        param1.moveTo(param2.x, param2.y);
        var _loc7_ : Float = 0.01;
        while (_loc7_ < 1.01)
        {
            _loc8_ = _loc6_.getValue(_loc7_);
            param1.lineTo(_loc8_.x, _loc8_.y);
            _loc7_ = _loc7_ + 0.01;
        }
    }
    
    public static function curveThroughPoints(param1 : Graphics, param2 : Array<Dynamic>, param3 : Float = 0.5, param4 : Float = 0.75, param5 : Bool = true) : Void
    {
        var cmds : Vector<Int> = null;
        var pars : Vector<Float> = null;
        var p : Array<Dynamic> = null;
        var duplicates : Array<Dynamic> = null;
        var i : Int = 0;
        var firstPt : Int = 0;
        var lastPt : Int = 0;
        var controlPts : Array<Dynamic> = null;
        var straightLines : Bool = false;
        var p0 : Point = null;
        var p1 : Point = null;
        var p2 : Point = null;
        var a : Float = Math.NaN;
        var b : Float = Math.NaN;
        var c : Float = Math.NaN;
        var cos : Float = Math.NaN;
        var C : Float = Math.NaN;
        var aPt : Point = null;
        var bPt : Point = null;
        var cPt : Point = null;
        var ax : Float = Math.NaN;
        var ay : Float = Math.NaN;
        var bx : Float = Math.NaN;
        var by : Float = Math.NaN;
        var rx : Float = Math.NaN;
        var ry : Float = Math.NaN;
        var r : Float = Math.NaN;
        var theta : Float = Math.NaN;
        var controlDist : Float = Math.NaN;
        var controlScaleFactor : Float = Math.NaN;
        var controlAngle : Float = Math.NaN;
        var controlPoint2 : Point = null;
        var controlPoint1 : Point = null;
        var isStraight : Bool = false;
        var bezier : BezierSegment = null;
        var t : Float = Math.NaN;
        var val : Point = null;
        var g : Graphics = param1;
        var points : Array<Dynamic> = param2;
        var z : Float = param3;
        var angleFactor : Float = param4;
        var moveTo : Bool = param5;
        try
        {
            cmds = new Vector<Int>();
            pars = new Vector<Float>();
            p = points.copy();
            duplicates = new Array<Dynamic>();
            i = 0;
            while (i < p.length)
            {
                if (!(Std.is(p[i], Point)))
                {
                    throw new Error("Array must contain Point objects");
                }
                if (i > 0)
                {
                    if (p[i].x == p[i - 1].x && p[i].y == p[i - 1].y)
                    {
                        duplicates.push(i);
                    }
                }
                i++;
            }
            i = as3hx.Compat.parseInt(duplicates.length - 1);
            while (i >= 0)
            {
                p.splice(duplicates[i], 1);
                i--;
            }
            if (z <= 0)
            {
                z = 0.5;
            }
            else if (z > 1)
            {
                z = 1;
            }
            if (angleFactor < 0)
            {
                angleFactor = 0;
            }
            else if (angleFactor > 1)
            {
                angleFactor = 1;
            }
            if (p.length > 2)
            {
                firstPt = 1;
                lastPt = as3hx.Compat.parseInt(p.length - 1);
                if (p[0].x == p[p.length - 1].x && p[0].y == p[p.length - 1].y)
                {
                    firstPt = 0;
                    lastPt = p.length;
                }
                controlPts = new Array<Dynamic>();
                i = firstPt;
                while (i < lastPt)
                {
                    p0 = (i - 1 < 0) ? p[p.length - 2] : p[i - 1];
                    p1 = p[i];
                    p2 = (i + 1 == p.length) ? p[1] : p[i + 1];
                    a = Point.distance(p0, p1);
                    if (a < 0.001)
                    {
                        a = 0.001;
                    }
                    b = Point.distance(p1, p2);
                    if (b < 0.001)
                    {
                        b = 0.001;
                    }
                    c = Point.distance(p0, p2);
                    if (c < 0.001)
                    {
                        c = 0.001;
                    }
                    cos = (b * b + a * a - c * c) / (2 * b * a);
                    if (cos < -1)
                    {
                        cos = -1;
                    }
                    else if (cos > 1)
                    {
                        cos = 1;
                    }
                    C = Math.acos(cos);
                    aPt = new Point(p0.x - p1.x, p0.y - p1.y);
                    bPt = new Point(p1.x, p1.y);
                    cPt = new Point(p2.x - p1.x, p2.y - p1.y);
                    if (a > b)
                    {
                        aPt.normalize(b);
                    }
                    else if (b > a)
                    {
                        cPt.normalize(a);
                    }
                    aPt.offset(p1.x, p1.y);
                    cPt.offset(p1.x, p1.y);
                    ax = bPt.x - aPt.x;
                    ay = bPt.y - aPt.y;
                    bx = bPt.x - cPt.x;
                    by = bPt.y - cPt.y;
                    rx = ax + bx;
                    ry = ay + by;
                    if (rx == 0 && ry == 0)
                    {
                        rx = -bx;
                        ry = by;
                    }
                    if (ay == 0 && by == 0)
                    {
                        rx = 0;
                        ry = 1;
                    }
                    else if (ax == 0 && bx == 0)
                    {
                        rx = 1;
                        ry = 0;
                    }
                    r = Math.sqrt(rx * rx + ry * ry);
                    theta = Math.atan2(ry, rx);
                    controlDist = Math.min(a, b) * z;
                    controlScaleFactor = C / Math.PI;
                    controlDist = controlDist * (1 - angleFactor + angleFactor * controlScaleFactor);
                    controlAngle = theta + Math.PI / 2;
                    controlPoint2 = Point.polar(controlDist, controlAngle);
                    controlPoint1 = Point.polar(controlDist, controlAngle + Math.PI);
                    controlPoint1.offset(p1.x, p1.y);
                    controlPoint2.offset(p1.x, p1.y);
                    if (Point.distance(controlPoint2, p2) > Point.distance(controlPoint1, p2))
                    {
                        controlPts[i] = new Array<Dynamic>();
                        controlPts[i].push(controlPoint2, controlPoint1);
                    }
                    else
                    {
                        controlPts[i] = new Array<Dynamic>();
                        controlPts[i].push(controlPoint1, controlPoint2);
                    }
                    i++;
                }
                if (moveTo)
                {
                    cmds.push(1);
                    pars.push(p[0].x);
                    pars.push(p[0].y);
                    
                }
                else
                {
                    cmds.push(2);
                    pars.push(p[0].x);
                    pars.push(p[0].y);
                    
                }
                if (firstPt == 1)
                {
                    cmds.push(3);
                    pars.push(controlPts[1][0].x);
                    pars.push(controlPts[1][0].y);
                    pars.push(p[1].x);
                    pars.push(p[1].y);
                    
                }
                straightLines = true;
                i = firstPt;
                while (i < lastPt - 1)
                {
                    isStraight = i > 0 && Math.atan2(p[i].y - p[i - 1].y, p[i].x - p[i - 1].x) == Math.atan2(p[i + 1].y - p[i].y, p[i + 1].x - p[i].x) || i < p.length - 2 && Math.atan2(p[i + 2].y - p[i + 1].y, p[i + 2].x - p[i + 1].x) == Math.atan2(p[i + 1].y - p[i].y, p[i + 1].x - p[i].x);
                    if (straightLines && isStraight)
                    {
                        cmds.push(2);
                        pars.push(p[i + 1].x);
                        pars.push(p[i + 1].y);
                        
                    }
                    else
                    {
                        bezier = new BezierSegment(p[i], controlPts[i][1], controlPts[i + 1][0], p[i + 1]);
                        t = 0.01;
                        while (t < 1.01)
                        {
                            val = bezier.getValue(t);
                            cmds.push(2);
                            pars.push(val.x);
                            pars.push(val.y);
                            
                            t = t + 0.01;
                        }
                    }
                    i++;
                }
                if (lastPt == p.length - 1)
                {
                    cmds.push(3);
                    pars.push(controlPts[i][1].x);
                    pars.push(controlPts[i][1].y);
                    pars.push(p[i + 1].x);
                    pars.push(p[i + 1].y);
                    
                }
            }
            else if (p.length == 2)
            {
                cmds.push(1);
                pars.push(p[0].x);
                pars.push(p[0].y);
                
                cmds.push(2);
                pars.push(p[1].x);
                pars.push(p[1].y);
                
            }
            g.drawPath(cmds, pars, "nonZero");
            return;
        }
        catch (e : Error)
        {
            return;
        }
    }
}

