import 'package:flutter/material.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            margin: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children:[
                const Image(image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-pretty-smiling-girl-skier-calls-relatives-vis-smartphone-tells-about-her-winter-vacation-wears-snowboarding-goggles_273609-32709.jpg'),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Communicates with friends',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
                ),
              ],
            ),

          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)=>buildPostItem(context),
              separatorBuilder: (context,index)=>SizedBox(height: 8,),
              itemCount: 10),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
  Widget buildPostItem(context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://img.freepik.com/free-photo/beautiful-ginger-woman-posts-photos-social-networks-after-awesome-day-has-active-rest-winter-holds-mobile-phone-wears-hat-coat-protective-ski-glasses-poses-yellow-wall_273609-32708.jpg'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children:[
                        Text('Abedeleilah',style: TextStyle(
                          height: 1.4,
                        ),),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle,color: Colors.blue,size: 15,),

                      ],
                    ),
                    Text('January 21, 2024 at 11:00 pm',style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),),
                  ],
                ),
              ),
              const SizedBox(width: 15,),
              IconButton(onPressed: (){

              }, icon: const Icon(Icons.more_horiz,size: 16,),),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            'datadatadatadatadatadatadatadatadatadatada'
                'tadatadatadatadatadatadatadatadatadatadatadatadata'
                'tadatadatadatadatadatadatadatadatadatadatadatadata'
                'tadatadatadatadatadatadatadatadatadatadatadatadata',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0,top: 5,),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding:  const EdgeInsetsDirectional.only(end: 6.0),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: const Text('#software',style: TextStyle(color: Colors.blue,fontSize: 10),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4,),
              image: const DecorationImage(image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-pretty-smiling-girl-skier-calls-relatives-vis-smartphone-tells-about-her-winter-vacation-wears-snowboarding-goggles_273609-32709.jpg',),
                fit: BoxFit.cover,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_border,size: 16,color:defaultColor,),
                          const SizedBox(width: 5,),
                          Text('1000',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.comment_outlined,size: 16,color:defaultColor,),
                          const SizedBox(width: 5,),
                          Text('Comments',style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap:(){},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage('https://img.freepik.com/free-photo/beautiful-ginger-woman-posts-photos-social-networks-after-awesome-day-has-active-rest-winter-holds-mobile-phone-wears-hat-coat-protective-ski-glasses-poses-yellow-wall_273609-32708.jpg'),
                      ),
                      SizedBox(width: 15,),
                      Text('Write a comment ...',style: Theme.of(context).textTheme.bodySmall,),

                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    const Icon(Icons.favorite_border,size: 16,color:defaultColor,),
                    const SizedBox(width: 5,),
                    Text('Like',style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),
              )

            ],
          ),
        ],
      ),
    ),

  );
}

