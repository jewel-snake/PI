/*
в сисетме имеется 6 процессов, у каждого из которых есть приоретет и права доступа.
процессы могут делать системные вызовы, у каждого вызова есть порядковый номер, имя процесса которые его совершил и тип вызова
правило access_fs обозначает, что процесс может запросить у системы определённые области в памяти, указанные в списке
всего определено 6 областей:
#1 /lib
#2 /etc
#3 /home
#4 /bin
#5 /init
#6 /tmp
вызов access_fs_inode содержит номер , представляющий область памяти, куда хочет обратиться процесс
процедура arrange выводит в консоль все системные вызовы с данным типом запроса.
*/

priority(sh,3).
priority(init,1).
priority(apache,3).
priority(sql_server,3).
priority(tensor_flow_nn,4).
priority(network_manager,2).

domain_has_key(sh,execute).
domain_has_key(sh,access_fs([1,2,3,4,5,6])).

domain_has_key(apache,access_fs([1,2,3,4,6])).
domain_has_key(apache,use_network).
domain_has_key(apache,execute).

domain_has_key(init,override_system_settings).
domain_has_key(init,execute).
domain_has_key(init,access_fs([1,2,4,5,6])).

domain_has_key(sql_server,access_fs([1,2,3,6])).

domain_has_key(tensor_flow_nn,access_fs([1,3,4,6])).
domain_has_key(tensor_flow_nn,execute).

domain_has_key(network_manager,access_fs([1,2,6])).
domain_has_key(network_manager,override_system_settings).
domain_has_key(network_manager,use_network).

sys_call(  0,init,access_fs_inode(5)).
sys_call(  1,init,override_system_settings).
sys_call(  2,init,access_fs_inode(2)).
sys_call(  3,init,override_system_settings).
sys_call(  4,init,access_fs_inode(4)).
sys_call(  5,init,execute).
sys_call(  6,init,override_system_settings).
sys_call(  7,network_manager,access_fs_inode(2)).
sys_call(  8,network_manager,override_system_settings).
sys_call(  9,init,execute).
sys_call( 10,sql_server,access_fs_inode(2)).
sys_call( 11,sql_server,access_fs_inode(3)).
sys_call( 12,init,execute).
sys_call( 13,tensor_flow_nn,access_fs_inode(1)).
sys_call( 14,tensor_flow_nn,access_fs_inode(3)).
sys_call( 15,init,execute).
sys_call( 16,apache,access_fs_inode(1)).
sys_call( 17,apache,access_fs_inode(2)).
sys_call( 18,apache,access_fs_inode(3)).
sys_call( 19,apache,use_network).
sys_call( 20,tensor_flow_nn,execute).
sys_call( 21,sh,access_fs_inode(1)).
sys_call( 22,sh,access_fs_inode(2)).
sys_call( 23,sh,access_fs_inode(4)).

list_member(X,[X|_]).
list_member(X,[_|T]):- list_member(X,T). 

has_access(D,access_fs_inode(I)):-domain_has_key(D,access_fs(L)),list_member(I,L).
has_access(D,A):- domain_has_key(D,A).

sys_call_valid(N,D,K):- sys_call(N,D,K),has_access(D,K).

log(R,P):-sys_call(N,D,R),priority(D,P),
  write(N),write(' '),write(D),write(' '),write(R),write('\n');true.

arrange_based_on_priority(R,P):- log(R,P),
  (P < 4,P2 is P + 1, arrange_based_on_priority(R,P2)).

arrange(R):- arrange_based_on_priority(R,1).