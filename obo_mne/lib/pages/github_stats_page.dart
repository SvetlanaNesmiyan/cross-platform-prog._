import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../view_models/github_stats_view_model.dart';
import '../theme_provider.dart';

class GitHubStatsPage extends StatefulWidget {
  const GitHubStatsPage({super.key});

  @override
  State<GitHubStatsPage> createState() => _GitHubStatsPageState();
}

class _GitHubStatsPageState extends State<GitHubStatsPage> {
  final TextEditingController _usernameController = TextEditingController();
  final String defaultUsername = 'happymary16';

  @override
  void initState() {
    super.initState();
    _usernameController.text = defaultUsername;
  }

  void _loadStats() {
    final viewModel = Provider.of<GitHubStatsViewModel>(context, listen: false);
    viewModel.loadGitHubStats(_usernameController.text.trim());
  }

  void _loadMockStats() {
    final viewModel = Provider.of<GitHubStatsViewModel>(context, listen: false);
    viewModel.loadGitHubStatsMock(_usernameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Statistics'),
        backgroundColor: const Color.fromARGB(255, 55, 255, 188),
        foregroundColor: const Color.fromARGB(255, 255, 238, 238),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Consumer<GitHubStatsViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchField(viewModel),
                const SizedBox(height: 20),
                
                if (viewModel.isLoading) ...[
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 20),
                  const Text('Loading GitHub data...'),
                ] else if (viewModel.error != null) ...[
                  _buildErrorWidget(viewModel.error!, viewModel),
                ] else if (viewModel.profile != null) ...[
                  _buildProfileCard(viewModel),
                  const SizedBox(height: 20),
                  _buildStatsGrid(viewModel),
                  const SizedBox(height: 10),
                  Text(
                    viewModel.usingMockData 
                      ? '⚠️ Displaying demo data' 
                      : '✅ Real GitHub data',
                    style: TextStyle(
                      color: viewModel.usingMockData ? Colors.orange : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  _buildInitialState(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchField(GitHubStatsViewModel viewModel) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'GitHub Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _loadStats,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 55, 255, 188),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Load Real Data'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _loadMockStats,
              child: const Text('Use Demo Data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.analytics, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Enter a GitHub username and click "Load Real Data" for live statistics\nor "Use Demo Data" for demonstration',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error, GitHubStatsViewModel viewModel) {
    return Card(
      elevation: 4,
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 48),
            const SizedBox(height: 10),
            Text(
              error,
              style: const TextStyle(color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'You can use demo data to see how the app works:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loadMockStats,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Use Demo Data Instead'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(GitHubStatsViewModel viewModel) {
    final profile = viewModel.profile!;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profile.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              profile.name ?? profile.login,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '@${profile.login}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (profile.bio != null && profile.bio!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                profile.bio!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
            if (profile.location != null && profile.location!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 4),
                  Text(profile.location!),
                ],
              ),
            ],
            if (profile.blog != null && profile.blog!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.link, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    profile.blog!,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(GitHubStatsViewModel viewModel) {
    final stats = viewModel.stats!;
    
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _StatCard(
          title: 'Repositories',
          value: stats['repositories']?.toString() ?? '0',
          icon: Icons.folder,
          color: Colors.blue,
        ),
        _StatCard(
          title: 'Followers',
          value: stats['followers']?.toString() ?? '0',
          icon: Icons.people,
          color: Colors.green,
        ),
        _StatCard(
          title: 'Following',
          value: stats['following']?.toString() ?? '0',
          icon: Icons.person_add,
          color: Colors.orange,
        ),
        _StatCard(
          title: 'Account Age',
          value: '${stats['accountAge'] ?? 0} years',
          icon: Icons.calendar_today,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}