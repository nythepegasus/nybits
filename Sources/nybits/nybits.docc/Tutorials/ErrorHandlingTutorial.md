# Error Handling Examples

#### Error handling example with passed `Error`:
```swift
let e: Error?

{ err in
    ... // Code to run if there is an error, and it will be in `err`, can be omitted
} <~| e |~> {
    ... // Code to run if there was no error, can be omitted
}
```

#### Error handling example without passed `Error`:
```swift
{
    print("Error occurred!")
} <~| e |~> {
    print("No error!")
}
```

#### Error handling examples omitting post closure:
```swift
{
    print("Error occurred!")
} <~| e
```

#### Error handling examples omitting pre closure:
```swift
e |~> {
    print("No error!")
}

e |~> { err in
    print(err.localizedDescription)
}
```
