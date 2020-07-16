# GitBlamePR
Mac app that shows pull request last modified each line of a file.Written in SwiftUI.

![Dec-20-2019 23-50-30](./Captures/c1.gif)

## Xcode Source Editor Extension
GitBlamePR.app bundles Xcode Source Editor Extension.  

Files opened in Xcode can be easily opened in GitBlamePR.app.  
I recommend that you set a key binding for this function.

![Xcode Source Editor Extension](./Captures/c2.gif)

## URL Scheme
GitBlamePR.app defines a URL scheme that can open the specified file.  
```
gitblamepr://{fileFullPath}
```

So you can easily open the specified file using command line, e.g:  
```bash
$ open gitblamepr://$(realpath example.txt | nkf -WwMQ | tr = %)
```

## Installation
Download the latest [release](https://github.com/maoyama/GitBlamePR/releases), unzip, and run GitBlamePR.app.

## Requirements
macOS Catalina
