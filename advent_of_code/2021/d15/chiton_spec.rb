# frozen_string_literal: true

require 'super_diff/rspec'
require_relative 'chiton'
require 'pry'

RSpec.describe LegacyChiton do
  context 'example input' do
    let(:input) do
      <<~INPUT
        1163751742
        1381373672
        2136511328
        3694931569
        7463417111
        1319128137
        1359912421
        3125421639
        1293138521
        2311944581
      INPUT
    end

    let(:chilton) { described_class.new(input) }

    it 'solves puzzle one' do
      expect(chilton.solve_puzzle_one).to eq 40
    end
  end

  context 'simple' do
    let(:input) do
      <<~INPUT
        123
        111
        456
      INPUT
    end

    let(:chilton) { described_class.new(input) }
    let(:paths) do
      [[[0, 0], [1, 0], [2, 0], [2, 1]],
       [[0, 0], [1, 0], [1, 1], [2, 1]],
       [[0, 0], [1, 0], [1, 1], [1, 2]]]
    end
    it 'filters paths' do
      expect(chilton.filter_paths).to eq(paths)
    end

    it 'solves puzzle one' do
      expect(chilton.solve_puzzle_one).to eq 9
    end
  end
end

RSpec.describe PriorityQueueChiton do
  context 'example input' do
    let(:input) do
      <<~INPUT
        1163751742
        1381373672
        2136511328
        3694931569
        7463417111
        1319128137
        1359912421
        3125421639
        1293138521
        2311944581
      INPUT
    end

    let(:chilton) { described_class.new(input) }

    describe 'legacy interface' do
      it 'solves puzzle one' do
        expect(chilton.solve_puzzle_one).to eq 40
      end
    end

    context 'elementary input' do
      let(:input) do
        <<~INPUT
          123
          111
          456
        INPUT
      end

      let(:chilton) { described_class.new(input) }
      let(:paths) do
        [[[0, 0], [1, 0], [2, 0], [2, 1]],
         [[0, 0], [1, 0], [1, 1], [2, 1]],
         [[0, 0], [1, 0], [1, 1], [1, 2]]]
      end
      it 'filters paths' do
        expect(chilton.filter_paths).to eq(paths)
      end

      it 'solves puzzle one' do
        expect(chilton.solve_puzzle_one).to eq 9
      end
    end

    describe 'Priority Queue interface' do
      context 'when Puzzle One' do
        it 'solves puzzle one with example input' do
          expect(chilton.solve_puzzle_one).to eq 40
        end

        it 'solves puzzle one with puzzle input via Ruby runner' do
          print PriorityQueueChiton.new(File.read('input')).find_path.eql?(363) ? '😀' : '😔'
        end
      end

      describe 'Part two' do
        let(:explored_input) do
          <<-INPUT
          11637517422274862853338597396444961841755517295286
          13813736722492484783351359589446246169155735727126
          21365113283247622439435873354154698446526571955763
          36949315694715142671582625378269373648937148475914
          74634171118574528222968563933317967414442817852555
          13191281372421239248353234135946434524615754563572
          13599124212461123532357223464346833457545794456865
          31254216394236532741534764385264587549637569865174
          12931385212314249632342535174345364628545647573965
          23119445813422155692453326671356443778246755488935
          22748628533385973964449618417555172952866628316397
          24924847833513595894462461691557357271266846838237
          32476224394358733541546984465265719557637682166874
          47151426715826253782693736489371484759148259586125
          85745282229685639333179674144428178525553928963666
          24212392483532341359464345246157545635726865674683
          24611235323572234643468334575457944568656815567976
          42365327415347643852645875496375698651748671976285
          23142496323425351743453646285456475739656758684176
          34221556924533266713564437782467554889357866599146
          33859739644496184175551729528666283163977739427418
          35135958944624616915573572712668468382377957949348
          43587335415469844652657195576376821668748793277985
          58262537826937364893714847591482595861259361697236
          96856393331796741444281785255539289636664139174777
          35323413594643452461575456357268656746837976785794
          35722346434683345754579445686568155679767926678187
          53476438526458754963756986517486719762859782187396
          34253517434536462854564757396567586841767869795287
          45332667135644377824675548893578665991468977611257
          44961841755517295286662831639777394274188841538529
          46246169155735727126684683823779579493488168151459
          54698446526571955763768216687487932779859814388196
          69373648937148475914825958612593616972361472718347
          17967414442817852555392896366641391747775241285888
          46434524615754563572686567468379767857948187896815
          46833457545794456865681556797679266781878137789298
          64587549637569865174867197628597821873961893298417
          45364628545647573965675868417678697952878971816398
          56443778246755488935786659914689776112579188722368
          55172952866628316397773942741888415385299952649631
          57357271266846838237795794934881681514599279262561
          65719557637682166874879327798598143881961925499217
          71484759148259586125936169723614727183472583829458
          28178525553928963666413917477752412858886352396999
          57545635726865674683797678579481878968159298917926
          57944568656815567976792667818781377892989248891319
          75698651748671976285978218739618932984172914319528
          56475739656758684176786979528789718163989182927419
          67554889357866599146897761125791887223681299833479
          INPUT
        end

        context 'with larger input' do
          let(:explored_chilton) { described_class.new(explored_input) }
          it 'still solves puzzle one with larger input' do
            expect(explored_chilton.find_path).to eq 315
            print PriorityQueueChiton.new(File.read('input')).find_path.eql?(315) ? '🚀' : '🗿'
          end
        end

        it '.increment_map_copy generates incremented map copy' do
          expect(
            chilton.increment_map_copy(chilton.map)
          ).to eq(
            [[2, 2, 7, 4, 8, 6, 2, 8, 5, 3],
             [2, 4, 9, 2, 4, 8, 4, 7, 8, 3],
             [3, 2, 4, 7, 6, 2, 2, 4, 3, 9],
             [4, 7, 1, 5, 1, 4, 2, 6, 7, 1],
             [8, 5, 7, 4, 5, 2, 8, 2, 2, 2],
             [2, 4, 2, 1, 2, 3, 9, 2, 4, 8],
             [2, 4, 6, 1, 1, 2, 3, 5, 3, 2],
             [4, 2, 3, 6, 5, 3, 2, 7, 4, 1],
             [2, 3, 1, 4, 2, 4, 9, 6, 3, 2],
             [3, 4, 2, 2, 1, 5, 5, 6, 9, 2]]
          )
        end

        it '.increment_map_copy generates incremented map copy' do
          chilton.discover_map
          expect(chilton.map).to eq(
            explored_input.split.map { _1.chars.map(&:to_i) }
          )
        end
        it 'solves puzzle two' do
          expect(chilton.solve_puzzle_two).to eq 315
        end
      end
    end
  end
end
