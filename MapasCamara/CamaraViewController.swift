//
//  CamaraViewController.swift
//  MapasCamara
//
//  Created by Daniel Esteban Alcantara on 21/11/26.
//

import UIKit
import Photos

class CamaraViewController: UIViewController {
    
    lazy var addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.configuration = .plain()
        button.configuration?.imagePadding = 0
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular)
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var photo : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    private func setUpView(){
        view.addSubview(addButton)
        view.addSubview(photo)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            
            photo.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -50),
            photo.heightAnchor.constraint(equalToConstant: 200),
            photo.widthAnchor.constraint(equalToConstant: 200),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    private func openCamera(){
        guard UIImagePickerController.isSourceTypeAvailable(.camera)else{
            print("La cámara no esta disponible")
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func addPhoto(){
        openCamera()
    }

}


extension CamaraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        if let image {
            print("Fotografía obtenida: \(image)")
            photo.image = image
        }
        picker.dismiss(animated: true)
    }
}
