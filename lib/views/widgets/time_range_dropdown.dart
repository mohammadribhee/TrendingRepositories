import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/repository_viewmodel.dart';

class TimeRangeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RepositoryViewModel>(context, listen: true);
    return DropdownButton<String>(
      value: viewModel.selectedTimeRange,
      items: const [
        DropdownMenuItem(value: 'Last Day', child: Text('Last Day')),
        DropdownMenuItem(value: 'Last Week', child: Text('Last Week')),
        DropdownMenuItem(value: 'Last Month', child: Text('Last Month')),
      ],
      onChanged: (value) {
        viewModel.setTimeRange(value!); // Clear old data and fetch new range
      },
    );
  }
}
