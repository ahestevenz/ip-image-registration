## Registración de Imágenes Multimodales

Este repositorio cuenta con una serie de *scripts* que permiten registrar imágenes médicas provenientes de diferentes fuentes (registración multimodal).

### MIFullRegister

Registración a través de *fuerza bruta*. Realiza una serie de combinaciones pre-configuradas correspondiente a los movimientos de rotación y traslación con el objetivo de obtener el valor máximo de la información mutua entre las imágenes *fixed* y *moving*. Dado que este procesamiento demora muchas horas (incluso días) se utiliza *parallel computing*.

<p align="center"><img src="https://github.com/ahestevenz/qt-mca/blob/8d0b8f2cf9175fbc5ce53d5e0bf471c49045a8d2/img/img_conf.png" width="600"></p>

### MetropolisMIRegister

El algoritmo implementado en este *script* utiliza la información mutua y la técnica Metrópolis como medida de similitud y método de búsqueda estocástica respectivamente. La fusión de imágenes 2D se realizó
a partir de la maximización de su información mutua y con transformaciones de rotación y traslación, con resultados satisfactorios en cuanto a la alineación geométrica de las mismas. Este trabajo se realizó en el contexto del proyecto ARPET*.

<p align="center"><img src="https://github.com/ahestevenz/qt-mca/blob/8d0b8f2cf9175fbc5ce53d5e0bf471c49045a8d2/img/img_conf.png" width="600"></p>

*AR-PET: Primer Tomógrafo por Emsión de Positrones Argentino, C. Verrastro, D. Estryk, E. Venialgo, S. Marinsek, M. Belzunce, XXXV Reunión Anual de la Asociación Argentina de Tecnología Nuclear, Noviembre 2008.
