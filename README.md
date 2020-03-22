# SwiftUI-Samples

## Half Modal 

It is *Map Application Style Half Modal* . 

You can swipe the drawer and set three position that is bottom, middle and top. 

![fig1](https://github.com/SatoTakeshiX/SwiftUI-Samples/blob/master/images/fig1.png)

### How to use 

```swift
struct ContentView: View {
    var body: some View {
        MapView()
            .drawer {
                VStack {
                    Text("Maitland Bay")
                        .font(.headline)
                    Spacer()
                }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}
```