# CustomModalDemo
Since Apple doesn't provide any built-in approach to show a ViewController as modal on iPhone. The PoppableProtocol in this demo makes it possible to show any custom view controllers in modal with custom size. 

## Features
1. same behaviour as built-in formSheet style on iPad
2. supports iPhone and iPad
3. handles orientation changes
4. doesn't interrupt keyboard in the presenting view controller
5. custom size
6. animation toggleable
7. dimming view toggleable

## Pretty simple to use
1. make your view controller adopt PoppableProtocol, implement var modalSize { get }
2. just call showAsPopover() dismissAsPopover()


![modal](https://user-images.githubusercontent.com/46996132/55789554-ebc08800-5afd-11e9-81f7-4575257d27ad.gif)
