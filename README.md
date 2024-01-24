# Stuverse - Student Alumni Community Forum

Welcome to Stuverse, a Flutter project aimed at creating a robust student alumni community forum with four main modules - Forum, Mentor, Job, and Fund. Additionally, there is a common module for authentication and user profiles. This README file serves as a guide to contributors, outlining the project structure, contribution guidelines, and important information.

## Project Structure

The project is organized into five main feature folders:

1. **Common:** Contains shared components, services, and utilities for authentication and user profiles.
2. **Forum:** Forum chat module for communication between students, staff, alumni, and external companies.
3. **Mentor:** Mentorship module for students to post mentorship requests to peer students, alumni, or external companies.
4. **Job:** Job portal for posting job and internship opportunities.
5. **Fund:** Fundraising module for raising funds for charity, student projects, arts, sports, etc.

Each feature folder includes the following sub-folders:

- **cubit:** Contains the Cubit classes responsible for managing the state of the feature.
- **models:** Holds the data models specific to each feature.
- **routes:** Stores the GoRouter route files for navigation within the feature.
- **services:** Includes services related to the feature.
- **views:** Contains the UI components specific to each feature.
- **utils:** Holds utility classes and constants specific to each feature.
- **widgets:** Includes reusable widgets specific to each feature.

Additionally, the `lib/app` folder includes:

- **routes:** Main navigation points with the central `routes.dart` file importing feature-specific route files.
- **utils:** Contains global utility classes such as `app_images.dart` and `app_theme.dart`.
- **views:** The root of the app, with `root_app.dart` serving as the starting point for `MaterialApp`.
- **app.dart:** Exports all necessary files for easy import in other parts of the app.

## Contributing

### How to Contribute

1. Fork the repository and clone it locally.
2. Create a new branch for each issue or feature.
3. Make changes and commit them to the respective branch.
4. Raise a pull request for review.

### Pull Request Guidelines

- Each pull request should address a specific feature or issue.
- Provide a clear and concise description of the changes.
- Ensure that assets for each module are added to the corresponding folders in `assets/`.
- Include image references as class fields in the respective module's `utils` folder.
- Use package imports for files outside the feature and relative imports inside the feature.
- Follow the existing project structure and naming conventions.
- Ensure that the code follows best practices and is well-documented.

### Code Structure

For consistent code structure, each feature has a corresponding file (e.g., `forum.dart`) in the feature folder, which exports all relevant files.

### Routing

The project uses GoRouter, and each feature has a `routes` folder containing a route file (e.g., `forum_routes.dart`). Import these files into the main `routes.dart` in `lib/app` for navigation.

Feel free to explore and contribute to the Stuverse project. Happy coding!
