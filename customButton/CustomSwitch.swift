//
//  CustomSwitch.swift
//  customButton
//
//  Created by DD Dev on 2020/12/29.
//  Copyright © 2020 John Kim. All rights reserved.
//

import UIKit

protocol CustomSwitchDelegate {
    func switchWillValueChange(sender: CustomSwitch, currentValue: Bool)
    func switchDidValueChange(sender: CustomSwitch, currentValue: Bool)
}

class CustomSwitch: UIControl {
    
    //////////////////////////////////////
    // Local Values
    public var onTintColor = UIColor.purple
    public var offTintColor = UIColor.gray
    public var thumbOnTintColor = UIColor.red {
        didSet {
            self.thumbView.backgroundColor = self.thumbOnTintColor
        }
    }
    public var thumbOffTintColor = UIColor.lightGray {
        didSet {
            self.thumbView.backgroundColor = self.thumbOffTintColor
        }
    }
    
  
    @IBInspectable
    public var isOn:Bool = true {
        didSet {
            self.setUISwitch()
        }
    }
    public var delegate: CustomSwitchDelegate?
    
    fileprivate let cornerRadius: CGFloat = 0.5
    fileprivate let thumbCornerRadius: CGFloat = 0.5
    fileprivate let thumbShadowColor: UIColor = UIColor.black
    fileprivate let thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2)
    fileprivate let thumbShaddowRadius: CGFloat = 1.5
    fileprivate let thumbShaddowOppacity: Float = 0.4
    fileprivate let thumbView = UIView(frame: CGRect.zero)
    fileprivate let bodyView = UIView(frame: CGRect.zero)
    fileprivate var isAnimating = false
    fileprivate var onPoint = CGPoint.zero
    fileprivate var offPoint = CGPoint.zero
    fileprivate let marginForTopBottom: CGFloat = 9
    //////////////////////////////////////
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUISwitch()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUISwitch()
    }
    
    /// 터치 이벤트가 발생하였을때 호출되는 함수.
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        if self.delegate == nil {
            self.animated()
        } else {
            self.delegate?.switchWillValueChange(sender: self, currentValue: self.isOn)
        }
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.backgroundColor = .clear
        
        let padding: CGFloat = 0.0
        
        // thumb 크기 설정
        let thumbSize =  CGSize(width: self.bounds.size.height , height: self.bounds.height)
        
        self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - padding , y: 0.0)
        self.offPoint = CGPoint(x: padding, y: 0.0)
        
        self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
        self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
        
        let bodySize = CGSize(width: self.bounds.size.width, height: self.bounds.height - marginForTopBottom)
        let bodyFrameY = (self.bounds.height - bodySize.height) / 2
        self.bodyView.frame = CGRect(x: 0.0, y: bodyFrameY, width: bodySize.width, height: bodySize.height)
        self.bodyView.layer.cornerRadius = bodySize.height * self.thumbCornerRadius
    }
}

// MARK:- Public Functions
extension CustomSwitch {
    
    func refreshColor() {
        setUISwitch()
    }
    
    func setOn(_ on: Bool, animated: Bool) {
        if animated {
            self.animated(on: on)
        } else {
            self.isOn = on
        }
    }
}

// MARK:- Private Functions
extension CustomSwitch {
    
    private func setUISwitch() {
        clear()
        
        // view의 크기에 벗어나는 컨텐츠를 크롭(Crop)하지 않게 설정
        self.clipsToBounds = false
        
        // Thumb View 설정
        self.thumbView.backgroundColor = self.isOn ? thumbOnTintColor : self.thumbOffTintColor
        self.thumbView.isUserInteractionEnabled = false
        
        // Shadow Color 설정
        self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        
        // Body View 설정
        self.bodyView.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        self.bodyView.isUserInteractionEnabled = false
        
        self.addSubview(self.bodyView)
        self.addSubview(self.thumbView)
    }
    
    fileprivate func animated(on: Bool? = nil) {
        self.isOn = on ?? !self.isOn        // on이 nil이면 self.on 대입
        
        self.isAnimating = true
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 0.7,     // 0과 1 사이의 수로 0에 가까울수록 애니메이션은 더 진동한다.
            initialSpringVelocity: 0.5,      // 애니메이션을 시작할 때 뷰의 상대적 속도.
            options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], //UIViewAnimationsOptions값 다른 애니메이션과 동일
            animations: {
                self.changeViewsByAction()
        }) { (isFinished) in
            self.completeAction()
        }
    }
    
    private func changeViewsByAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.thumbView.backgroundColor = self.isOn ? self.thumbOnTintColor : self.thumbOffTintColor
        self.bodyView.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
    }
    
    private func completeAction() {
        self.isAnimating = false
        self.sendActions(for: UIControl.Event.valueChanged)
        if self.delegate != nil {
            self.delegate?.switchDidValueChange(sender: self, currentValue: self.isOn)
        }
    }
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

class CustomSwitchThumbView: UIView {
    
    fileprivate(set) var thumbImageView = UIImageView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.thumbImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.thumbImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.thumbImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.thumbImageView.layer.cornerRadius = self.layer.cornerRadius
        self.thumbImageView.clipsToBounds = self.clipsToBounds
    }
}
