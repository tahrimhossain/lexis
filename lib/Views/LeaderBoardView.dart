import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Blocs/LeaderBoardBloc/LeaderBoard_Bloc.dart';
import 'package:lexis/Services/API.dart';

class LeaderBoardView extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const LeaderBoardView({Key? key,required this.categoryId,required this.categoryName}) : super(key: key);

  @override
  State<LeaderBoardView> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends State<LeaderBoardView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LeaderBoardBloc(
            RepositoryProvider.of<API>(context)
        )..add(LoadLeaderBoardEvent(categoryId: widget.categoryId)),
        child: BlocBuilder<LeaderBoardBloc,LeaderBoardState>(
          builder: (context,state){
            if(state is LoadingLeaderBoardState){
              return const Scaffold(
                backgroundColor: Color(0xFF283048),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else if(state is LoadedLeaderBoardState){
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xFF00587a),
                  centerTitle: true,
                  title: Text(widget.categoryName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white
                    ),
                  ),
                ),
                body:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(state.leaderBoard.topScorers!.isEmpty)...[
                      const Center(
                        child: Text("Nothing to show",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black87
                        ),),
                      )
                    ]else...[
                      Expanded(
                        child: ListView.separated(
                        itemCount: state.leaderBoard.topScorers!.length,
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 17),
                        itemBuilder: (context, index){
                          return Container(
                            height: (135/812)*MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFF00587a),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black45,
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0
                                  )
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text((index+1).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white
                                  ),
                                ),
                                Text(state.leaderBoard.topScorers![index].name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white
                                  ),
                                ),
                                Text("Score: "+state.leaderBoard.topScorers![index].score.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),

                          );
                        },
                        separatorBuilder:(context,index){
                          return const SizedBox(height: 30,);
                        } ,
                      ),
                      )
                    ]
                  ],
                )
              );
            }else{
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                ),
                backgroundColor: const Color(0xFF283048),
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Something went wrong!",style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white),),
                        ElevatedButton(onPressed:(){
                          context.read<LeaderBoardBloc>().add(LoadLeaderBoardEvent(categoryId: widget.categoryId));
                        },
                          child: const Text("Retry"),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF00587a),
                          ),
                        )
                      ],
                    )
                ),
              );
            }
          },
        ),
    );
  }



}
