library dynamic_treeview;

import 'package:flutter/material.dart';

///Callback when child/parent is tapped . Map data will contain {String 'id',String 'parent_id',String 'title',Map 'extra'}
typedef OnDelete = Function(BaseData data);

///A tree view that supports indefinite category/subcategory lists with horizontal and vertical scrolling
class TreeView extends StatefulWidget {
  ///DynamicTreeView will be build based on this.Create a model class and implement [BaseData]

//  final StreamController<BaseData> streamController;
  final TreeViewController controller;

  ///Called when DynamicTreeView parent or children gets tapped.
  ///Map will contain the following keys :
  ///id , parent_id , title , extra
  final OnDelete onDelete;

  ///The width of DynamicTreeView
  final double width;

  ///Configuration object for [TreeView]
  final Config config;

  final List<BaseData> initialValue;

  TreeView({
    this.config = const Config(),
    required this.onDelete,
    this.width = 220.0,
    required this.controller,
    this.initialValue = const [],
//    this.streamController,
  }) : assert(config.rootData != null);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  List<ParentWidget> treeView = [];

//	List<BaseData> data = List();
  TreeViewController _childTapListener = TreeViewController();

  buildTreeView(List<BaseData> baseData) {
    print("Listning ******");
//		data = List();
//		data.addAll(baseData);
    setState(() {
      _buildTreeView(widget.controller.getBaseData());
    });
  }

//  List<ParentWidget> widgets;
  @override
  void didChangeDependencies() {
//		_buildTreeView();
    widget.controller.addListener(() {
      buildTreeView(widget.controller.getBaseData());
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      widget.controller.addAllBaseData(widget.initialValue);
      buildTreeView(widget.controller.getBaseData());
    }
    _childTapListener.addListener(childTapListener);
    super.initState();
  }

  void childTapListener() {
    setState(() {
      treeView.removeWhere((widget) {
        widget.children.removeWhere((test) {
          return test.key == _childTapListener.getKey();
        });
        return widget.key == _childTapListener.getKey();
      });
//      cW.removeWhere((childWidget) => childWidget.key == _childTapListener.getKey());
//	    widget.data.remove(_childTapListener.getMapValue());
    });
  }

  @override
  void dispose() {
    _childTapListener.removeListener(childTapListener);
    _childTapListener.dispose();
    super.dispose();
  }

  _buildTreeView(List<BaseData> data) {
    var k = data
        .where((data) {
          return data.getParentId() == widget.config.rootId;
        })
        .map((data) {
          return data.getId();
        })
        .toSet()
        .toList()
      ..sort((i, j) => i.compareTo(j));
    List<ParentWidget> widgets = <ParentWidget>[];

    k.forEach((f) {
      ParentWidget p = buildWidget(f, '');
      if (p != null) widgets.add(p);
    });
    treeView = widgets;
    print("TREEWIDGET : $treeView");
  }

  ParentWidget buildWidget(String parentId, String name) {
    var data = _getChildrenFromParent(parentId);
    BaseData d = widget.controller.getBaseData().firstWhere((item) {
      return item.getId() == parentId.toString();
    });
    if (name == null) {
      name = d.getTitle();
    }

    var p = ParentWidget(
      baseData: d,
      onDelete: widget.onDelete,
      config: widget.config,
      children: _buildChildren(data),
      key: ObjectKey({
        'id': '${d.getId()}',
        'parent_id': '${d.getParentId()}',
        'title': '${d.getTitle()}',
        'extra': '${d.getExtraData()}'
      }),
    );
    return p;
  }

  _buildChildren(List<BaseData> data) {
    List<Widget> cW = <Widget>[];
    for (var item in data) {
      var c = _getChildrenFromParent(item.getId());
      if ((c.length ?? 0) > 0) {
        //has children
        var name = data
            .firstWhere((d) => d.getId() == item.getId().toString())
            .getTitle();
        cW.add(buildWidget(item.getId(), name));
      } else {
        GlobalKey key = GlobalObjectKey({
          'id': '${item.getId()}',
          'parent_id': '${item.getParentId()}',
          'title': '${item.getTitle()}',
          'extra': '${item.getExtraData()}'
        });
        cW.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {0: FractionColumnWidth(.80)},
          children: [
            TableRow(children: [
              Text(
                "${item.getTitle()}",
                maxLines: 2,
                style: item.getExtraData() != null &&
                        (item.getExtraData()['innerParent'] as bool)
                    ? widget.config.innerParentTextStyle
                    : widget.config.childrenTextStyle,
              ),
              IconButton(
                onPressed: () {
                  widget.onDelete(item);
                  _childTapListener.addKey(key);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ])
          ],
        ));
      }
    }
    return cW;
  }

  List<BaseData> _getChildrenFromParent(dynamic parentId) {
    return widget.controller.getBaseData().where((item) {
      return item.getParentId() == parentId.toString();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTreeProvider(
      childTapListener: _childTapListener,
      child: Container(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: treeView,
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  final List<Widget> children;
  final bool shouldExpand;
  final Config config;

  ChildWidget(
      {this.children = const [],
      required this.config,
      this.shouldExpand = true});

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> sizeAnimation;
  late AnimationController expandController;

  @override
  void didUpdateWidget(ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldExpand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void initState() {
    prepareAnimation();
    super.initState();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void prepareAnimation() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    Animation curve =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    sizeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(curve as Animation<double>);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sizeAnimation,
      builder: (context, _) {
        return SizeTransition(
          sizeFactor: sizeAnimation,
          axisAlignment: -1.0,
          child: Column(
            children: _buildChildren(),
          ),
        );
      },
    );
  }

  _buildChildren() {
    return widget.children.map((c) {
      // return c;
      return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: widget.config.childrenPaddingEdgeInsets,
            child: c,
          ));
    }).toList();
  }
}

class ParentWidget extends StatefulWidget {
  final List<Widget> children;
  final BaseData baseData;
  final Config config;
  final OnDelete onDelete;

  ParentWidget({
    required this.baseData,
    required this.onDelete,
    required this.children,
    required this.config,
    required Key key,
  }) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget>
    with SingleTickerProviderStateMixin {
  bool shouldExpand = true;
  late Animation<double> sizeAnimation;
  late AnimationController expandController;
  late TreeViewController _childTapListener;

  @override
  void dispose() {
    super.dispose();
    expandController.dispose();
  }

  @override
  void didChangeDependencies() {
    _childTapListener = DynamicTreeProvider.of(context)!.childTapListener;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    prepareAnimation();
    /* _childTapListener.addListener(() {
      print("Parent Clicked ${_childTapListener.getMapValue()}");
    });*/
    super.initState();
  }

  void prepareAnimation() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    expandController.forward();
    Animation curve =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    sizeAnimation =
        Tween(begin: 0.0, end: -0.25).animate(curve as Animation<double>);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          /*onTap: () {
						var map = Map<String, dynamic>();
						map['id'] = widget.baseData.getId();
						map['parent_id'] = widget.baseData.getParentId();
						map['title'] = widget.baseData.getTitle();
						map['extra'] = widget.baseData.getExtraData();
						if (widget.onTap != null) widget.onTap(widget.baseData);
					},*/
          title: Text(widget.baseData.getTitle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.baseData.getExtraData() != null &&
                      (widget.baseData.getExtraData()['innerParent'] != null
                          ? widget.baseData.getExtraData()['innerParent']
                          : false)
                  ? widget.config.innerParentTextStyle
                  : widget.config.parentTextStyle),
          contentPadding: widget.config.parentPaddingEdgeInsets,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedBuilder(
                animation: sizeAnimation,
                builder: (context, _) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        shouldExpand = !shouldExpand;
                      });
                      if (shouldExpand) {
                        expandController.reverse();
                      } else {
                        expandController.forward();
                      }
                    },
                    icon: RotationTransition(
                      turns: sizeAnimation,
                      child: widget.config.arrowIcon,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  var map = Map<String, dynamic>();
                  map['id'] = widget.baseData.getId();
                  map['parent_id'] = widget.baseData.getParentId();
                  map['title'] = widget.baseData.getTitle();
                  map['extra'] = widget.baseData.getExtraData();
                  widget.onDelete(widget.baseData);
//                  _childTapListener.addMapValue(widget.baseData);
                  _childTapListener.addKey(widget.key as Key);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ],
          ),
        ),
        ChildWidget(
          children: widget.children,
          config: widget.config,
          shouldExpand: shouldExpand,
        )
      ],
    );
  }
}

class DynamicTreeProvider extends InheritedWidget {
  final TreeViewController childTapListener;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  DynamicTreeProvider({
    Key? key,
    required Widget child,
    required this.childTapListener,
  }) : super(key: key, child: child);

  static DynamicTreeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DynamicTreeProvider>();
  }
}

///A singleton Child tap listener
class TreeViewController extends ChangeNotifier {
  List<BaseData> _baseData = [];
  Key? _key;

  /*TreeViewController({BaseData rootData}) {
    _baseData = List();
    _baseData.add(rootData != null ? rootData : Config().rootData);
    notifyListeners();
  }*/

  void addKey(Key key) {
    this._key = key;
    notifyListeners();
  }

  Key getKey() {
    return this._key as Key;
  }

  void addBaseData(BaseData data) {
    /*	this._baseData = List();
  	this._baseData.add(DataModel());*/
    this._baseData.add(data);

    notifyListeners();
  }

  void addAllBaseData(List<BaseData> data) {
    /*	this._baseData = List();
  	this._baseData.add(DataModel());*/
    this._baseData.addAll(data);

    notifyListeners();
  }

  ///a=0 , b=1 c=1
  int _loopIndex = 1;

  void removeBaseData(BaseData data) {
    BaseData _baseData = this._baseData.singleWhere(
          (test) => test.getId() == data.getId(),
        );
    List<BaseData> baseDatum = [];
    if (_baseData != null) {
      baseDatum.add(_baseData);
      this._baseData.remove(_baseData);
      print("baseDatum initial :: $baseDatum");
      for (int i = 0; i < _loopIndex; i++) {
        List<BaseData> _child = this
            ._baseData
            .where((element) => baseDatum.any((elementDatum) =>
                elementDatum.getId() == element.getParentId()))
            .toList();
        print("baseDatum child :: $_child");
        if (_child != null && _child.isNotEmpty) {
          baseDatum.addAll(_child);
          this._baseData.removeWhere((element) => _child.contains((element)));
          print("baseDatum addAll :: $baseDatum");
          _loopIndex = _loopIndex + 1;
        }
      }
    }
    notifyListeners();
  }

  void removeAllData() {
    this._baseData.clear();
    notifyListeners();
  }

  List<BaseData> getBaseData() {
    return this._baseData;
  }
}

///Dynamic TreeView will construct treeview based on parent-child relationship.So, its important to
///override getParentId() and getId() with proper values.
abstract class BaseData {
  ///id of this data
  getId();

  /// parentId of a child
  getParentId();

  /// Text displayed on the parent/child tile
  String getTitle();

  ///Any extra data you want to get when tapped on children
  Map<String, dynamic> getExtraData();
}

class DataModel implements BaseData {
  final id;
  final parentId;
  final String name;

  ///Any extra data you want to get when tapped on children
  final Map<String, dynamic> extras;

  const DataModel(
      {this.id = "0",
      this.parentId = -1,
      this.name = "Root",
      this.extras = const {}});

  @override
  String getId() {
    return this.id.toString();
  }

  @override
  Map<String, dynamic> getExtraData() {
    return this.extras;
  }

  @override
  String getParentId() {
    return this.parentId.toString();
  }

  @override
  String getTitle() {
    return this.name;
  }

  @override
  String toString() {
    return 'DataModel{id: $id, parentId: $parentId, name: $name, extras: $extras}';
  }
}

class Config {
  final TextStyle parentTextStyle;
  final TextStyle innerParentTextStyle;
  final TextStyle childrenTextStyle;
  final EdgeInsets childrenPaddingEdgeInsets;
  final EdgeInsets parentPaddingEdgeInsets;

  ///implement [BaseData] into a model Class this will be the base of [TreeView]
  final BaseData rootData = const DataModel();

  ///Animated icon when tile collapse/expand
  final Widget arrowIcon;

  ///the rootid of a treeview.This is needed to fetch all the immediate child of root
  ///Default is 1
  final String rootId;

  const Config(
      {this.parentTextStyle =
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      this.innerParentTextStyle =
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      this.parentPaddingEdgeInsets = const EdgeInsets.all(6.0),
      this.childrenTextStyle = const TextStyle(color: Colors.black),
      this.childrenPaddingEdgeInsets =
          const EdgeInsets.only(left: 15.0, top: 0, bottom: 0),
      this.rootId = "0",
//      this.rootData = const DataModel(),
      this.arrowIcon = const Icon(Icons.keyboard_arrow_down)});
}
