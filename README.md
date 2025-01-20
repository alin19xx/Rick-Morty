# Rick-Morty

This project is a Rick & Morty app designed with Clean Architecture, MVVM, and SwiftUI. The application displays a list of characters from the show, including filtering options and a name search feature. It also includes a detailed view for each character.

### **1. Data**
- **Repositories** Handle interactions with the Rick & Morty API. (https://rickandmortyapi.com/)
- **Networking Module** Built with a NetworkClient and error handling.
- **Async/Await**: Used for asynchronous network calls.

### **2. Domain**
- **FetchCharactersUseCase** Fetch the list of characters, with parameters for pagination and filtering.
- **FetchCharacterDetailUseCase** Fetch detailed information for a specific character.

### **3. Presentation**
- **ViewModels** Designed using the `ObservableObject` pattern to notify views of changes using `@Published` properties.
- **Pagination**: Infinite scrolling implemented using prefetching to load data in advance.

### **4. Testing**
-  Unit tests are implemented for the Domain, Data, and Presentation layers, including ViewModels:
  - Mocks for UseCases and Repositories were created to test ViewModels, focusing on pagination and error handling.
  - Error Handling Tests: Validate the 404 error is handled properly.

### **5. Image Caching**
- A custom image caching system using a singleton (ImageCache) based on NSCache for optimized image loading and a reusable CachedAsyncImage component.
- Prevents unnecessary network requests and improves performance.

### **6. Logger**
- Supports logging levels (info, error, debug, etc.).
- Enabled only in `DEBUG` builds.
