//
//  ViewController.swift
//  DrawingSample
//
//  Created by TienBM on 10/26/17.
//  Copyright © 2017 tienbm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tool: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var red:CGFloat = 0.0
    var green:CGFloat = 0.0
    var blue:CGFloat = 0.0
    var brushSize:CGFloat = 5.0
    var opacityValue:CGFloat = 1.0
    var lastPoint = CGPoint.zero
    var swiped = false
    var isDrawing = true
    var toolDraw: UIImageView!
    var isErase = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.imageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.imageView)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.imageView.frame.width, height: self.imageView.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushSize)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacityValue).cgColor)
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func createToolDraw() {
        toolDraw = UIImageView()
        toolDraw.frame = CGRect(x: self.imageView.bounds.size.width, y: self.imageView.bounds.size.height, width: 38, height: 38)
        toolDraw.image = #imageLiteral(resourceName: "EraserIcon")
        self.view.addSubview(toolDraw)
    }
    
    func removeAllSubView() {
        if let viewWithTag = self.toolDraw.viewWithTag(999) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
    @IBAction func erase(_ sender: Any) {
        if (isDrawing) {
            (red,green,blue) = (255, 255, 255)
            brushSize = 20.0
        } else {
            (red,green,blue) = (0,0,0)
            brushSize = 5
        }
        isDrawing = !isDrawing
        isErase = !isErase
        
    }
    
    @IBAction func reset(_ sender: Any) {
        self.imageView.image = nil
        (red,green,blue) = (0,0,0)
    }
    
    @IBAction func colorPicker(_ sender: UIButton) {
        if sender.tag == 0 {
            (red,green,blue) = (1,0,0)
        } else if sender.tag == 1 {
            (red,green,blue) = (0,1,0)
        } else if sender.tag == 2 {
            (red,green,blue) = (0,0,1)
        } else if sender.tag == 3 {
            (red,green,blue) = (1,0,1)
        } else if sender.tag == 4 {
            (red,green,blue) = (1,1,0)
        } else if sender.tag == 5 {
            (red,green,blue) = (0,1,1)
        } else if sender.tag == 6 {
            (red,green,blue) = (1,1,1)
        } else if sender.tag == 7 {
            (red,green,blue) = (0,0,0)
        }
    }
    
}

