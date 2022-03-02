# vagemcast

[![CI](https://github.com/jjorgemoura/vagemcast/actions/workflows/.ci.yml/badge.svg)](https://github.com/jjorgemoura/vagemcast/actions/workflows/.ci.yml)
[![iOS](https://img.shields.io/badge/iOS-15.2-blue.svg)](https://github.com/apple/swift)
[![License](https://img.shields.io/github/license/jjorgemoura/vagemcast)](https://github.com/jjorgemoura/vagemcast/blob/main/LICENSE)

This repo contains the full source code for Vagemcast, an iOS podcast vplayer.

Soon to be available on the App Store.

---

* [About](#about)
* [Getting Started](#getting-started)
* [Related Projects](#related-projects)
* [Credits](#credits)
* [License](#license)

## About

Vagemcast allows users to browse and play their favourite podcasts.

### Features

It has three main features:

* Search podcasts from podcast registry.
* Subscribe and download podcasts.
* Play podcasts.

### Why one more podcast app?

There is one main reasonbehind the creation of this app.

This codebase is a good opportunity to play and test with new and trendy technologies and several tools and APIs that, otherwise, would not be easy.

Some of the technologies used:

* The Composable Architecture
* Latest iOS API (Swift UI, Swift concurrency, Combine, etc)
* Github actions and Xcode cloud

#### The Composable Architecture

The whole application is powered by the [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture), a library by [Point-Free](https://www.pointfree.co/collections/composable-architecture) that provides tools for building applications with a focus on composability, modularity, and testability.

A brief description from the authors:

>
> This means:
>
> * The entire app's state is held in a single source of truth, called a `Store`.
> * The entire app's behavior is implemented by a single unit, called a `Reducer`, which is composed out of many other reducers.
> * All effectful operations are made explicit as values returned from reducers.
> * Dependencies are made explicit as simple data types wrapping their live implementations, along with various mock instances.
>
> There are a ton of benefits to designing applications in this manner:
>
> * Large, complex features can be broken down into smaller child domains, and those domains can communicate via simple state mutations. Typically this is done in SwiftUI by accessing singletons inside `ObservableObject` instances, but this is not necessary in the Composable Architecture.
> * We take control of dependencies rather than allow them to take control of us. Just because you are using `StoreKit`, `GameCenter`, `UserNotifications`, or any other 3rd party APIs in your code, it doesn't mean you should sacrifice your ability to run your app in the simulator, SwiftUI previews, or write concise tests.
> * Exhaustive tests can be written very quickly. We test very detailed user flows, capture subtle edge cases, and assert on how effects execute and how their outputs feed back into the application.
> * It is straightforward to write integration tests that exercise multiple independent parts of the application.
>

The codebase also employs some of the best practices for modern app development adopted by Pointfree, such as:

* Hyper-modularization

* Preview apps

## Getting Started

The codebase strucure follows the same structure adopted by Pointfree on theirs [isowords](https://github.com/pointfreeco/isowords) repo.

The root path contains all modules as SPM modules. The main app is inside the folder `Apps`.

## Related Projects

This application makes use of a number of open source projects built by me, including:

* [Alfaz](https://github.com/jjorgemoura/alfaz)
* [Beatz](https://github.com/jjorgemoura/beatz)
* [Defectz](https://github.com/jjorgemoura/defectz)
* [Gavetaz](https://github.com/jjorgemoura/gavetaz)
* [Variationz](https://github.com/jjorgemoura/variationz)

## Credits

* [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) powers the app architecture.

## License

MIT License. For more information see the full [license](LICENSE.md).
