//
//  Person.swift
//  GoldenGoals
//
//  Struct used for displaying people thanked in the ABOUT section of the app.
//
//  Created by Thomas Andre Johansen on 03/10/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import Foundation
import UIKit

struct Person{
    var name: String
    var url: String? //not everyone provides an url
    var image: UIImage?//not everyone provides an image
    var text: String?
}
