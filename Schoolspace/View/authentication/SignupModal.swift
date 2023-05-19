//
//  SignupModal.swift
//  School space
//
//  Created by Mohamed Abbes on 16/3/2023.
//

import SwiftUI
import FirebaseStorage

struct SignupModal: View {
    let countries = ["+216", "+44", "+91", "+86"]
       @State private var selectedCountry = "+216"
    @Environment(\.presentationMode) var presentationMode
    @State private var isVerifyModalShown = false
    @Binding var givenFname: String
    @Binding var givenLname: String
    @Binding var givenEmail: String
    @Binding var givenPassword: String
    @StateObject var viewModel = SignupViewModel()
    @State private var downloadUrl: String = ""

    @State private var image: UIImage? = UIImage(systemName: "person.circle")
    @State private var isShowingImagePicker = false
    @State private var givenPn: String = ""
    @State private var givenRc: String = ""
    @State private var givenDb: Date = Date()
    @State private var givenRt: String = ""
    let classOptions = ["4 SIM 1", "4 SIM 2", "4 SIM 3"]
    let roleOptions = ["Teacher", "Student", "Parent"]
    var body: some View {
        VStack (alignment:.center, spacing: 8){
            
            Image("icon_exit")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture(perform: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                })
            
            
            Text("Complete your profile")
                .padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.bold)
            
            Text("Please type in your profile informations")
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.light)
            VStack(alignment:.center, spacing: 20){
                
                
                ZStack {
                    Circle()
                        .strokeBorder(Color.gray, lineWidth: 2)
                        .frame(width: 100, height: 100)
                    if let uiImage = image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    }
                }
                .onTapGesture {
                    isShowingImagePicker = true
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePickerView(sourceType: .photoLibrary) { uiImage in
                        image = uiImage
                        uploadImageToFirebaseStorage(image: uiImage) { result in
                            switch result {
                            case .success(let urlString):
                                print("Profile photo URL: \(urlString)")
                                downloadUrl = urlString;
                                // Here you can add code to save the downloadURL to your database
                            case .failure(let error):
                                print("Error uploading profile photo: \(error.localizedDescription)")
                            }
                        }
                        
                    }
                }
                
                VStack{
                    Text("Phone number").padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.regular)
                    
                    HStack {
                        Picker("", selection: $selectedCountry) {
                            ForEach(countries, id: \.self) { country in
                                Text(country)
                            }
                        }
                        .frame(width: 100)
                        .clipped()
                        .padding(.leading, 0)
                        
                        TextField(
                            "type in your phone number",
                            text: $givenPn
                        )
                        .frame(height: 50)
                        .padding(.leading, 16)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                        )
                    }
                    .padding(.horizontal, 16)
                    
                }
                
                
                VStack{
                    Text("Registration code")
                        .padding(.leading) .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.regular)
                    
                    TextField(
                        "type in your registration code",
                        text: $givenRc
                    )
                    .frame(height: 50)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                VStack{
                    Text("Date of Birth")
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.regular)
                    
                    DatePicker(
                        "Date of birth :",
                        selection: $givenDb,
                        in: ...Date(),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .frame(height: 50)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                VStack {
                    Text("Role type")
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.regular)
                    
                    Picker(selection: $givenRt, label: Text("Select your role type")) {
                        Text("Teacher").tag("Teacher")
                        Text("Student").tag("Student")
                        Text("Parent").tag("Parent")
                    }
                    .labelsHidden()
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .frame(height: 50)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(0xFFC5C6CC), lineWidth: 1.0)
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            Button(action: {
                
                isVerifyModalShown = true
                viewModel.registerUser(email: givenEmail, password: givenPassword, firstName: givenFname, lastName: givenLname, dateOfBirth: givenDb, registrationCode: givenRc, phoneNumber: givenPn, roleType: givenRt, profilePhoto: downloadUrl)
                
                
            }) {
                // 1
                Text("Confirm registration")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .foregroundColor(.white) // 2
            .background(Color(0xFF016DB1))
            .cornerRadius(10) // 4
            .padding()
            .sheet(isPresented:
                    $isVerifyModalShown) {
                OtpModal()
            }
                   
            
        }
        .padding(.top,16)
        
    
    }
    func uploadImageToFirebaseStorage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
           guard let imageData = image.jpegData(compressionQuality: 0.5) else {
               return
           }
           
           let filename = UUID().uuidString
           let storageRef = Storage.storage().reference().child("profile_photos/\(filename).jpg")
           let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
               if let error = error {
                   print("Error uploading profile photo: \(error.localizedDescription)")
                   return
               }
               storageRef.downloadURL { url, error in
                   if let error = error {
                       print("Error getting profile photo URL: \(error.localizedDescription)")
                       return
                   }
                   guard let downloadURL = url else {
                       return
                   }
                   print("Profile photo URL: \(downloadURL.absoluteString)")
                   // Here you can add code to save the downloadURL to your database
                   let urlString = downloadURL.absoluteString
                          completion(.success(urlString))
               }
           }
       }
}
struct CustomPickerLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Text(configuration.title as? String ?? "")
            .foregroundColor(.black) // Set the text color to black
            .font(.system(size: 17, weight: .medium))
    }
}
struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerViewCoordinator
    
    private let sourceType: UIImagePickerController.SourceType
    private let onImageSelected: (UIImage) -> Void
    
    init(sourceType: UIImagePickerController.SourceType, onImageSelected: @escaping (UIImage) -> Void) {
        self.sourceType = sourceType
        self.onImageSelected = onImageSelected
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update needed
    }
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        ImagePickerViewCoordinator(onImageSelected: onImageSelected)
    }
}



class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private let onImageSelected: (UIImage) -> Void
     private let storage: Storage
     private let storageRef: StorageReference
     
     init(onImageSelected: @escaping (UIImage) -> Void) {
         self.onImageSelected = onImageSelected
         self.storage = Storage.storage()
         self.storageRef = storage.reference(forURL: "gs://profile-83d21.appspot.com/")
         super.init()
     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        onImageSelected(uiImage)
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_photos/\(filename).jpg")
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading profile photo: \(error.localizedDescription)")
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting profile photo URL: \(error.localizedDescription)")
                    return
                }
                guard let downloadURL = url else {
                    return
                }
                print("Profile photo URL: \(downloadURL.absoluteString)")
                // Here you can add code to save the downloadURL to your database
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

