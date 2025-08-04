import 'package:flutter/material.dart';

void showCustomModelSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (context) => const CustomModelContent(),
  );
}

class CustomModelContent extends StatelessWidget {
  const CustomModelContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity,),
          Text('You\'re almost there!'),
          SizedBox(height: 8,),
          Text('Enter Mobile Number', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),),
          SizedBox(height: 40,),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mobile Number',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          SizedBox(height: 16,),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Send OTP'),
          ),
          SizedBox(height: 16,),
          Row(
            
          children: [
            Checkbox.adaptive(value: true, onChanged: (onChanged){}),
            Text('I agree to receive updates over Whatsapp', style: Theme.of(context).textTheme.bodySmall,),
          ],
          )
        ],
      ),
    );
  }
}


