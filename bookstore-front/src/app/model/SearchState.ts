export class SearchState {


  engaged: boolean = false;
  fields: Map<string, string> = new Map<string, string>();


}
export function provideEmptySearchState(): SearchState{
  let state: SearchState = new SearchState()
  state.engaged = true;
  state.fields = null;
  return state;
}
